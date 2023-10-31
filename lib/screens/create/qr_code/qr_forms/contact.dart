// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_quill/models/create_model.dart';
import 'package:qr_quill/screens/create/qr_code/create_qr_results.dart';
import 'package:qr_quill/shared/animations.dart';
import 'package:qr_quill/shared/button.dart';
import 'package:qr_quill/shared/constants.dart';
import 'package:qr_quill/shared/navigator.dart';
import 'package:qr_quill/shared/snackbar.dart';
import 'package:qr_quill/shared/textfield.dart';

class ContactForm extends StatefulWidget {
  ContactForm({super.key, required this.qrCodeName});

  String qrCodeName;

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> with SingleTickerProviderStateMixin {
  String fullname = '';
  String phoneNumber = '';
  String address = '';
  String email = '';

  final _formKey = GlobalKey<FormState>();
  bool obscureText = true;
  bool isLoading = false;

  String stringData = '';

  String generateQrData(String name, String phoneNumber, String email, String address) {
    return 'BEGIN:VCARD\n'
      'VERSION:3.0\n'
      'FN:$name\n'
      'TEL:$phoneNumber\n'
      'EMAIL:$email\n'
      'ADR:$address\n'
      'END:VCARD';
  }

  validateForm() async {
    if (_formKey.currentState!.validate()) {
      // Collect all data
      stringData = 'Name: $fullname\nPhone: $phoneNumber\nEmail: $email\nAddress: $address';

      showSnackbar(context, 'Generating QR Code...');
      setState(() {
        isLoading = true;
      });

      await Future.delayed(kAnimationDuration2);
      navigatorPush(context, ShowQRCode(
        qrData: generateQrData(fullname, phoneNumber, email, address),
        stringData: stringData,
        qrCodeName: widget.qrCodeName,
        selectedCategory: QRCodeCategory.Contact,
        )
      );
    } else {
      showSnackbar(context, 'Field validation failed. Ensure all fields are valid.');
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          NormalTextField(
            hintText: 'Full Name',
            textColor: kSecondaryColor,
            onChanged: (value) {
              setState(() {
                fullname = value!;
              });
            }, 
            enabledBorderColor: kFontTheme(context), 
            focusedBorderColor: kSecondaryColor, 
            errorBorderColor: kRedColor, 
            focusedErrorBorderColor: kRedColor, 
            errorTextStyleColor: kRedColor, 
            iconColor: kSecondaryColor, 
            cursorColor: kSecondaryColor, 
            prefixIcon: Icons.person,
          ),
    
          NormalTextField(
            hintText: 'Phone Number',
            textColor: kSecondaryColor,
            textInputType: TextInputType.phone,
            onChanged: (value) {
              setState(() {
                phoneNumber = value!;
              });
            }, 
            enabledBorderColor: kFontTheme(context), 
            focusedBorderColor: kSecondaryColor, 
            errorBorderColor: kRedColor, 
            focusedErrorBorderColor: kRedColor, 
            errorTextStyleColor: kRedColor, 
            iconColor: kSecondaryColor, 
            cursorColor: kSecondaryColor, 
            prefixIcon: Icons.phone,
          ),
    
          EmailTextField(
            onChanged: (value) {
              setState(() {
                email = value!;
              });
            }, 
            enabledBorderColor: kFontTheme(context), 
            focusedBorderColor: kSecondaryColor, 
            errorBorderColor: kRedColor, 
            focusedErrorBorderColor: kRedColor, 
            errorTextStyleColor: kRedColor, 
            iconColor: kSecondaryColor, 
            cursorColor: kSecondaryColor, 
          ),
    
          NormalTextField(
            hintText: 'Address',
            maxLines: 4,
            textColor: kSecondaryColor,
            onChanged: (value) {
              setState(() {
                address = value!;
              });
            }, 
            enabledBorderColor: kFontTheme(context), 
            focusedBorderColor: kSecondaryColor, 
            errorBorderColor: kRedColor, 
            focusedErrorBorderColor: kRedColor, 
            errorTextStyleColor: kRedColor, 
            iconColor: kSecondaryColor, 
            cursorColor: kSecondaryColor, 
            prefixIcon: Icons.place,
          ),

          Button(
            buttonColor: kSecondaryColor,
            buttonText: 'Generate QR Code',
            onPressed: () {
              validateForm();
            },
            inactive: false,
          ),
          SizedBox(height:10.h),
        ].animate(
          interval: kAnimationDurationMs(100),
          effects: MyEffects.fadeSlide(offset: const Offset(-0.05, 0)),
        ),
      ),
    );
  }
}
