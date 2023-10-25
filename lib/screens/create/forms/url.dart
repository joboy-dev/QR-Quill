// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:qr_quill/shared/animations.dart';
import 'package:qr_quill/shared/constants.dart';
import 'package:qr_quill/shared/textfield.dart';

class URLForm extends StatefulWidget {
  URLForm({super.key, required this.url});

  String url;

  @override
  State<URLForm> createState() => _URLFormState();
}

class _URLFormState extends State<URLForm> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        URLTextField(
          hintText: 'URL',
          initialValue: 'https://',
          textColor: kSecondaryColor,
          onChanged: (value) {
            setState(() {
              widget.url = value!;
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
      ].animate(
        interval: kAnimationDurationMs(100),
        effects: MyEffects.fadeSlide(offset: const Offset(-0.05, 0)),
      ),
    );
  }
}
