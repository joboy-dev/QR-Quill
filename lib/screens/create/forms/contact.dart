// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:qr_quill/shared/animations.dart';
import 'package:qr_quill/shared/constants.dart';
import 'package:qr_quill/shared/textfield.dart';

class ContactForm extends StatefulWidget {
  ContactForm({super.key, required this.fullname, required this.phoneNumber, required this.address, required this.email});

  String fullname, phoneNumber, address, email;

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NormalTextField(
          hintText: 'Full Name',
          textColor: kSecondaryColor,
          onChanged: (value) {
            setState(() {
              widget.fullname = value!;
            });
          }, 
          enabledBorderColor: kFontTheme(context), 
          focusedBorderColor: kSecondaryColor, 
          errorBorderColor: kRedColor, 
          focusedErrorBorderColor: kRedColor, 
          errorTextStyleColor: kRedColor, 
          iconColor: kSecondaryColor, 
          cursorColor: kSecondaryColor, 
          prefixIcon: Icons.person,
        ),

        NormalTextField(
          hintText: 'Phone Number',
          textColor: kSecondaryColor,
          textInputType: TextInputType.phone,
          onChanged: (value) {
            setState(() {
              widget.phoneNumber = value!;
            });
          }, 
          enabledBorderColor: kFontTheme(context), 
          focusedBorderColor: kSecondaryColor, 
          errorBorderColor: kRedColor, 
          focusedErrorBorderColor: kRedColor, 
          errorTextStyleColor: kRedColor, 
          iconColor: kSecondaryColor, 
          cursorColor: kSecondaryColor, 
          prefixIcon: Icons.phone,
        ),

        EmailTextField(
          onChanged: (value) {
            setState(() {
              widget.email = value!;
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

        NormalTextField(
          hintText: 'Address',
          maxLines: 4,
          textColor: kSecondaryColor,
          onChanged: (value) {
            setState(() {
              widget.address = value!;
            });
          }, 
          enabledBorderColor: kFontTheme(context), 
          focusedBorderColor: kSecondaryColor, 
          errorBorderColor: kRedColor, 
          focusedErrorBorderColor: kRedColor, 
          errorTextStyleColor: kRedColor, 
          iconColor: kSecondaryColor, 
          cursorColor: kSecondaryColor, 
          prefixIcon: Icons.place,
        ),
      ].animate(
        interval: kAnimationDurationMs(100),
        effects: MyEffects.fadeSlide(offset: const Offset(-0.05, 0)),
      ),
    );
  }
}
