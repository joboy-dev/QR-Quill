import 'package:flutter/material.dart';
import 'package:qr_quill/shared/constants.dart';

class DialogHeader extends StatelessWidget {
  const DialogHeader({
    super.key,
    required this.headerText,
    this.icon,
    required this.mainColor,
  });

  final String headerText;
  final IconData? icon;
  final Color mainColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: mainColor, size: 40.0),
            const SizedBox(width: 20.0),
            Text(
              headerText,
              style: kNormalTextStyle.copyWith(color: mainColor, fontSize: 22.0, fontWeight: FontWeight.bold,),
            )
          ],
        ),
        const SizedBox(height: 10.0),
        Divider(color: mainColor, thickness: 0.5),
        const SizedBox(height: 10.0),
      ],
    );
  }
}
