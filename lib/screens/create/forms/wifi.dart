// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qr_quill/shared/animations.dart';
import 'package:qr_quill/shared/constants.dart';
import 'package:qr_quill/shared/textfield.dart';

class WifiForm extends StatefulWidget {
  WifiForm({super.key, required this.wifiName, required this.widiPassword});

  String wifiName;
  String widiPassword;

  @override
  State<WifiForm> createState() => _WifiFormState();
}

class _WifiFormState extends State<WifiForm> with SingleTickerProviderStateMixin {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NormalTextField(
          hintText: 'Wifi Name',
          textColor: kSecondaryColor,
          onChanged: (value) {
            setState(() {
              widget.wifiName = value!;
            });
          }, 
          enabledBorderColor: kFontTheme(context), 
          focusedBorderColor: kSecondaryColor, 
          errorBorderColor: kRedColor, 
          focusedErrorBorderColor: kRedColor, 
          errorTextStyleColor: kRedColor, 
          iconColor: kSecondaryColor, 
          cursorColor: kSecondaryColor, 
          prefixIcon: Icons.wifi,
        ),

        NormalTextField(
          hintText: 'Wifi Password',
          textColor: kSecondaryColor,
          textInputType: TextInputType.visiblePassword,
          onChanged: (value) {
            setState(() {
              widget.widiPassword = value!;
            });
          }, 
          enabledBorderColor: kFontTheme(context), 
          focusedBorderColor: kSecondaryColor, 
          errorBorderColor: kRedColor, 
          focusedErrorBorderColor: kRedColor, 
          errorTextStyleColor: kRedColor, 
          iconColor: kSecondaryColor, 
          cursorColor: kSecondaryColor, 
          obscureText: obscureText,
          prefixIcon: Icons.password,
          suffixIcon: obscureText ? FontAwesomeIcons.solidEye : FontAwesomeIcons.solidEyeSlash,
          suffixIconOTap: () {
            setState(() {
              obscureText = !obscureText;
            });
          },
        ),
      ].animate(
        interval: kAnimationDurationMs(100),
        effects: MyEffects.fadeSlide(offset: const Offset(-0.05, 0)),
      ),
    );
  }
}
