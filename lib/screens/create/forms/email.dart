import 'package:flutter/material.dart';
import 'package:qr_quill/shared/constants.dart';
import 'package:qr_quill/shared/textfield.dart';

class EmailForm extends StatefulWidget {
  const EmailForm({super.key});

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
              // title = value!;
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
      ],
    );
  }
}
