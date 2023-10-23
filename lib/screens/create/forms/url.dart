import 'package:flutter/material.dart';
import 'package:qr_quill/shared/constants.dart';
import 'package:qr_quill/shared/textfield.dart';

class URLForm extends StatefulWidget {
  const URLForm({super.key});

  @override
  State<URLForm> createState() => _URLFormState();
}

class _URLFormState extends State<URLForm> with SingleTickerProviderStateMixin {
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
        URLTextField(
          hintText: 'Enter URL',
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
        ),
      ],
    );
  }
}
