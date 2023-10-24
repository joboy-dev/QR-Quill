import 'package:flutter/material.dart';
import 'package:qr_quill/shared/constants.dart';
import 'package:qr_quill/shared/navigator.dart';

class Button extends StatelessWidget {
  final String buttonText;
  final Function() onPressed;
  final Color buttonColor;
  final bool inactive;
  final double? width;
  final Color? textColor;

  const Button({
    super.key, 
    required this.buttonText,
    required this.onPressed,
    required this.buttonColor,
    required this.inactive,
    this.width,
    this.textColor
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      minWidth: width ?? 200.0,
      height: 50.0,
      color: inactive ? kTertiaryColor : buttonColor,
      focusColor: inactive
          ? kTertiaryColor.withOpacity(0.5)
          : buttonColor.withOpacity(0.5),
      elevation: inactive ? 1.0 : 2.0,
      focusElevation: inactive ? 1.0 : 4.0,
      splashColor: inactive
          ? kTertiaryColor.withOpacity(0.5)
          : buttonColor.withOpacity(0.5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(7.0),
      ),
      child: Text(
        buttonText,
        style: TextStyle(
          color: textColor ?? kPrimaryColor,
          fontSize: 17.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

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
      height: kHeightWidth(context).height * 0.5,
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
            flex: 2,
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
            Expanded(flex: 0, child: Icon(icon, color: iconColor, size: 30.0)),
            SizedBox(width: gap ?? 20.0),
            Expanded(
              flex: 1,
              child: Text(
                text,
                style: kNormalTextStyle.copyWith(
                  fontSize: fontSize ?? 20.0,
                  color: textColor ?? kTertiaryColor,
                  fontWeight: fontWeight ?? FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DoubleButton extends StatelessWidget {
  const DoubleButton({
    super.key,
    required this.inactiveButton,
    required this.button2Text,
    required this.button2Color,
    required this.button2onPressed,
  });

  final bool inactiveButton;
  final String button2Text;
  final Color button2Color;
  final Function() button2onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Button(
            buttonText: 'Cancel',
            onPressed: () {
              navigatorPop(context);
            },
            buttonColor: kRedColor,
            textColor: kTertiaryColor,
            inactive: false,
          ),
        ),
        const SizedBox(width: 5.0),
        Expanded(
          child: Button(
            buttonText: button2Text,
            onPressed: button2onPressed,
            buttonColor: button2Color,
            inactive: inactiveButton,
          ),
        ),
      ],
    );
  }
}

class ButtonText extends StatelessWidget {
  const ButtonText({
    super.key,
    required this.firstText,
    required this.secondText,
    required this.onTap,
  });

  final String firstText, secondText;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: RichText(
        text: TextSpan(
          text: firstText,
          style: kNormalTextStyle.copyWith(color: kFontTheme(context)),
          children: [
            TextSpan(
              text: secondText,
              style: kNormalTextStyle.copyWith(
                color: kSecondaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}