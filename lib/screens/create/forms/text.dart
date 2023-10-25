import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:qr_quill/shared/animations.dart';
import 'package:qr_quill/shared/constants.dart';
import 'package:qr_quill/shared/textfield.dart';

// ignore: must_be_immutable
class TextForm extends StatefulWidget {
  TextForm({super.key, required this.text});

  String text;

  @override
  State<TextForm> createState() => _TextFormState();
}

class _TextFormState extends State<TextForm> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextareaTextField(
          hintText: 'Enter Text',
          onChanged: (value) {
            setState(() {
              widget.text = value!;
            });
          }, 
          enabledBorderColor: kFontTheme(context), 
          focusedBorderColor: kSecondaryColor, 
          errorBorderColor: kRedColor, 
          focusedErrorBorderColor: kRedColor, 
          errorTextStyleColor: kRedColor, 
          cursorColor: kSecondaryColor, 
        ),
      ].animate(
        interval: kAnimationDurationMs(100),
        effects: MyEffects.fadeSlide(offset: const Offset(-0.05, 0)),
      ),
    );
  }
}
