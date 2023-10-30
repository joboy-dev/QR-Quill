// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_quill/models/create_model.dart';
import 'package:qr_quill/screens/create/create_qr_results.dart';
import 'package:qr_quill/shared/animations.dart';
import 'package:qr_quill/shared/button.dart';
import 'package:qr_quill/shared/constants.dart';
import 'package:qr_quill/shared/logger.dart';
import 'package:qr_quill/shared/navigator.dart';
import 'package:qr_quill/shared/snackbar.dart';
import 'package:qr_quill/shared/textfield.dart';

class TextForm extends StatefulWidget {
  const TextForm({super.key, required this.qrCodeName});

  final String qrCodeName;

  @override
  State<TextForm> createState() => _TextFormState();
}

class _TextFormState extends State<TextForm> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();

  String text = '';
  String stringData = '';

  bool obscureText = true;
  bool isLoading = false;

  validateForm() async {
    if (_formKey.currentState!.validate()) {
      logger(text);

      stringData = 'Text:\n$text';

      showSnackbar(context, 'Generating QR Code...');
      setState(() {
        isLoading = true;
      });

      await Future.delayed(kAnimationDuration2);
      navigatorPush(context, ShowQRCode(
          qrData: text ,
          stringData: stringData,
          qrCodeName: widget.qrCodeName,
          selectedCategory: Category.Text,
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
          TextareaTextField(
            hintText: 'Enter Text',
            onChanged: (value) {
              setState(() {
                text = value!;
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
