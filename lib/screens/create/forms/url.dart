// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_quill/models/qrcode_model.dart';
import 'package:qr_quill/screens/create/show_qrcode.dart';
import 'package:qr_quill/shared/animations.dart';
import 'package:qr_quill/shared/button.dart';
import 'package:qr_quill/shared/constants.dart';
import 'package:qr_quill/shared/logger.dart';
import 'package:qr_quill/shared/navigator.dart';
import 'package:qr_quill/shared/snackbar.dart';
import 'package:qr_quill/shared/textfield.dart';

class URLForm extends StatefulWidget {
  const URLForm({super.key, required this.qrCodeName});

  final String qrCodeName;


  @override
  State<URLForm> createState() => _URLFormState();
}

class _URLFormState extends State<URLForm> {
  String url = '';

  final _formKey = GlobalKey<FormState>();
  bool obscureText = true;
  bool isLoading = false;

  String stringData = '';

  validateForm() async {
    if (_formKey.currentState!.validate()) {
      logger(url);

      // Collect all data
      stringData = 'URL: $url';

      showSnackbar(context, 'Generating QR Code...');
      setState(() {
        isLoading = true;
      });

      await Future.delayed(kAnimationDuration2);
      navigatorPush(context, ShowQRCode(
        qrData: url,
        stringData: stringData,
        qrCodeName: widget.qrCodeName,
        selectedCategory: Category.URL,
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
          URLTextField(
            hintText: 'URL',
            initialValue: 'https://',
            textColor: kSecondaryColor,
            onChanged: (value) {
              setState(() {
                url = value!;
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
