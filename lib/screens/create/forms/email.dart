// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:qr_quill/shared/animations.dart';
import 'package:qr_quill/shared/constants.dart';
import 'package:qr_quill/shared/textfield.dart';

class EmailForm extends StatefulWidget {
  EmailForm({super.key, required this.email});

  String email;

  @override
  State<EmailForm> createState() => _EmailFormState();
}

class _EmailFormState extends State<EmailForm> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        EmailTextField(
          onChanged: (value) {
            setState(() {
              widget.email = value!;
            });
          }, 
          enabledBorderColor: kFontTheme(context), 
          focusedBorderColor: kSecondaryColor, 
          errorBorderColor: kRedColor, 
          focusedErrorBorderColor: kRedColor, 
          errorTextStyleColor: kRedColor, 
          cursorColor: kSecondaryColor, 
          iconColor: kSecondaryColor,
        ),
      ].animate(
        interval: kAnimationDurationMs(100),
        effects: MyEffects.fadeSlide(offset: const Offset(-0.05, 0)),
      ),
    );
  }
}
