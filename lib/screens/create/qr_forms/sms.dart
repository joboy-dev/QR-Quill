// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_quill/models/create_model.dart';
import 'package:qr_quill/screens/create/create_qr_results.dart';
import 'package:qr_quill/shared/animations.dart';
import 'package:qr_quill/shared/button.dart';
import 'package:qr_quill/shared/constants.dart';
import 'package:qr_quill/shared/navigator.dart';
import 'package:qr_quill/shared/snackbar.dart';
import 'package:qr_quill/shared/textfield.dart';

class SMSForm extends StatefulWidget {
  SMSForm({super.key, required this.qrCodeName});

  String qrCodeName;

  @override
  State<SMSForm> createState() => _SMSFormState();
}

class _SMSFormState extends State<SMSForm> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();

  String phoneNumber = '';
  String subject = '';
  String message= '';

  String stringData = '';

  /// Function to handle emailng of message
  String generateMessageQR(String phoneNumber, String message) {
    final String smsUri = 'sms:$phoneNumber?body=$message';
    return smsUri;  
  }

  validateForm() async {
    if (_formKey.currentState!.validate()) {

      // Collect all data
      stringData = 'To: $phoneNumber\n\nMessage:\n$message';

      showSnackbar(context, 'Generating QR Code...');

      await Future.delayed(kAnimationDuration2);
      navigatorPush(context, ShowQRCode(
        qrData: generateMessageQR(phoneNumber, message),
        stringData: stringData,
        qrCodeName: widget.qrCodeName,
        selectedCategory: Category.SMS,
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
            hintText: 'Receiver Phone Number',
            labelText: 'Phone Number',
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

          TextareaTextField(
          hintText: 'Enter Message',
          onChanged: (value) {
            setState(() {
              message = value!;
            });
          }, 
          enabledBorderColor: kFontTheme(context), 
          focusedBorderColor: kSecondaryColor, 
          errorBorderColor: kRedColor, 
          focusedErrorBorderColor: kRedColor, 
          errorTextStyleColor: kRedColor, 
          cursorColor: kSecondaryColor, 
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
