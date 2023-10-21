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
    return Column(
      children: [
        Text(
          text,
          style: kNormalTextStyle.copyWith(
            color: kTertiaryColor,
            fontSize: 20.0,
          ),
        ),
        const SizedBox(height: 20.0),
      ],
    );
  }
}