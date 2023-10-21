import 'package:flutter/material.dart';
import 'package:qr_quill/shared/constants.dart';

class DialogText extends StatelessWidget {
  const DialogText({
    super.key,
    required this.text
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    // final theme = context.watch<ThemeSwitch>().isDarkMode;

    return Column(
      children: [
        Text(
          text,
          style: kNormalTextStyle.copyWith(
            color: kFontTheme(context),
            fontSize: 20.0,
          ),
        ),
        const SizedBox(height: 20.0),
      ],
    );
  }
}