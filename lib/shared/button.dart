import 'package:flutter/material.dart';
import 'package:qr_quill/shared/constants.dart';

class ColumnButtonIcon extends StatelessWidget {
  final String buttonText;
  final Function() onPressed;
  final Color buttonColor;
  final IconData icon;

  const ColumnButtonIcon({
    super.key,
    required this.buttonText,
    required this.onPressed,
    required this.buttonColor,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      minWidth: double.infinity,
      height: MediaQuery.of(context).size.height * 0.5,
      color: buttonColor,
      focusColor: buttonColor.withOpacity(0.5),
      elevation: 2.0,
      focusElevation: 4.0,
      splashColor: buttonColor.withOpacity(0.5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(7.0),
      ),
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Icon(
              icon,
              size: 70.0,
              color: kPrimaryColor,
            ),
          ),
          const SizedBox(width: 5.0),
          Expanded(
            flex: 1,
            child: Text(
              buttonText,
              style: TextStyle(
                color: kPrimaryColor,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class IconTextButton extends StatelessWidget {
  const IconTextButton({
    super.key,
    required this.text,
    required this.icon,
    required this.iconColor,
    required this.onPressed,
    this.fontSize,
    this.textColor,
    this.gap,
    this.fontWeight,
  });

  final String text;
  final IconData icon;
  final Color iconColor;
  final Color? textColor;
  final double? fontSize;
  final double? gap;
  final FontWeight? fontWeight;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0),
        child: Row(
          children: [
            Icon(icon, color: iconColor),
            SizedBox(width: gap ?? 20.0),
            Text(
              text,
              style: kNormalTextStyle.copyWith(
                fontSize: fontSize ?? 17.0,
                color: textColor ?? kSecondaryColor,
                fontWeight: fontWeight ?? FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
