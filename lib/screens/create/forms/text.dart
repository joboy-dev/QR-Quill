import 'package:flutter/material.dart';
import 'package:qr_quill/shared/constants.dart';
import 'package:qr_quill/shared/textfield.dart';

class TextForm extends StatefulWidget {
  const TextForm({super.key});

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
              // title = value!;
            });
          }, 
          enabledBorderColor: kFontTheme(context), 
          focusedBorderColor: kSecondaryColor, 
          errorBorderColor: kRedColor, 
          focusedErrorBorderColor: kRedColor, 
          errorTextStyleColor: kRedColor, 
          cursorColor: kSecondaryColor, 
        ),
      ],
    );
  }
}
