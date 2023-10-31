// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_quill/models/create_model.dart';
import 'package:qr_quill/screens/create/qr_code/create_qr_results.dart';
import 'package:qr_quill/shared/animations.dart';
import 'package:qr_quill/shared/button.dart';
import 'package:qr_quill/shared/constants.dart';
import 'package:qr_quill/shared/logger.dart';
import 'package:qr_quill/shared/navigator.dart';
import 'package:qr_quill/shared/snackbar.dart';
import 'package:qr_quill/shared/textfield.dart';

class EmailForm extends StatefulWidget {
  EmailForm({super.key, required this.qrCodeName});

  String qrCodeName;

  @override
  State<EmailForm> createState() => _EmailFormState();
}

class _EmailFormState extends State<EmailForm> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  bool obscureText = true;
  bool isLoading = false;

  String email = '';
  String subject = '';
  String message= '';

  String data = '';
  String qrData = '';

  /// Function to handle emailng of message
  String generateMail(String email, String subject, String message) {
    final uri = Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: {
        'subject': subject,
        'body': message,
      },
    );

    return uri.toString();
  }

  validateForm() async {
    if (_formKey.currentState!.validate()) {
      logger(email);

      // Collect all data
      data = 'Email: $email\nSubject: $subject\n\nMessage:\n$message';
      qrData = generateMail(email, subject, message);

      showSnackbar(context, 'Generating QR Code...');
      setState(() {
        isLoading = true;
      });

      await Future.delayed(kAnimationDuration2);
      navigatorPush(context, ShowQRCode(
        qrData: qrData,
        stringData: data,
        qrCodeName: widget.qrCodeName,
        selectedCategory: QRCodeCategory.Email,
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
          EmailTextField(
            onChanged: (value) {
              setState(() {
                email = value!;
              });
            }, 
            hintText: 'Receiver Email',
            enabledBorderColor: kFontTheme(context), 
            focusedBorderColor: kSecondaryColor, 
            errorBorderColor: kRedColor, 
            focusedErrorBorderColor: kRedColor, 
            errorTextStyleColor: kRedColor, 
            cursorColor: kSecondaryColor, 
            iconColor: kSecondaryColor,
          ),

          NormalTextField(
            hintText: 'Subject',
            textColor: kSecondaryColor,
            onChanged: (value) {
              setState(() {
                subject = value!;
              });
            }, 
            enabledBorderColor: kFontTheme(context), 
            focusedBorderColor: kSecondaryColor, 
            errorBorderColor: kRedColor, 
            focusedErrorBorderColor: kRedColor, 
            errorTextStyleColor: kRedColor, 
            iconColor: kSecondaryColor, 
            cursorColor: kSecondaryColor, 
            prefixIcon: Icons.subject,
          ),

          TextareaTextField(
          hintText: 'Enter message',
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
