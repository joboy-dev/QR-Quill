import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qr_quill/shared/constants.dart';
import 'package:qr_quill/shared/textfield.dart';

class WifiForm extends StatefulWidget {
  const WifiForm({super.key});

  @override
  State<WifiForm> createState() => _WifiFormState();
}

class _WifiFormState extends State<WifiForm> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    controller = AnimationController(vsync: this, duration: kAnimationDuration2);
    animation = Tween(begin: 0.0, end: 0.0).animate(controller);

    controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
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
              // title = value!;
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
              // title = value!;
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
      ],
    );
  }
}
