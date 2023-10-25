// ignore_for_file: constant_identifier_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qr_quill/shared/animations.dart';
import 'package:qr_quill/shared/constants.dart';
import 'package:qr_quill/shared/logger.dart';
import 'package:qr_quill/shared/textfield.dart';

enum SocialLinks {WhatsApp, Facebook, Instagram, XTwitter, LinkedIn, YouTube, Other}

const socialIcons = {
  SocialLinks.WhatsApp: FontAwesomeIcons.whatsapp,
  SocialLinks.Facebook: FontAwesomeIcons.facebook,
  SocialLinks.Instagram: FontAwesomeIcons.instagram,
  SocialLinks.XTwitter: FontAwesomeIcons.xTwitter,
  SocialLinks.LinkedIn: FontAwesomeIcons.linkedin,
  SocialLinks.YouTube: FontAwesomeIcons.youtube,
  SocialLinks.Other: FontAwesomeIcons.link,
};

class SocialsForm extends StatefulWidget {
  SocialsForm({super.key, required this.link, this.selectedLink});

  String link;
  SocialLinks? selectedLink;

  @override
  State<SocialsForm> createState() => _SocialsFormState();
}

class _SocialsFormState extends State<SocialsForm> with SingleTickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropDownFormField(
          labelText: 'Choose',
          value: widget.selectedLink, 
          items: SocialLinks.values
            .map(
              (link) => DropdownMenuItem(
                value: link,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      link.name,
                      style: kNormalTextStyle.copyWith(fontSize: 15.sp),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Icon(
                        socialIcons[link],
                        size: 15.r,
                        color: kSecondaryColor,
                      ),
                    ),
                  ].animate(
                    interval: kAnimationDurationMs(100),
                    effects: MyEffects.slideShake(),
                  ),
                )
              ),
            )
          .toList(),
          onChanged: (value) {
            setState(() {
              widget.selectedLink = value;
            });
           logger('Selected Link: ${widget.selectedLink!.name}');
          }, 
          prefixIcon: Icons.link, 
          iconColor: kSecondaryColor, 
          enabledBorderColor: kFontTheme(context), 
          focusedBorderColor: kSecondaryColor, 
          errorBorderColor: kRedColor, 
          focusedErrorBorderColor: kRedColor, 
          errorTextStyleColor: kRedColor, 
        ),

        if (widget.selectedLink == SocialLinks.WhatsApp) URLTextField(
          hintText: 'WhatsApp',
          textColor: kSecondaryColor,
          icon: FontAwesomeIcons.whatsapp,
          onChanged: (value) {
            setState(() {
              widget.link = value!;
            });
          }, 
          enabledBorderColor: kFontTheme(context), 
          focusedBorderColor: kSecondaryColor, 
          errorBorderColor: kRedColor, 
          focusedErrorBorderColor: kRedColor, 
          errorTextStyleColor: kRedColor, 
          iconColor: kSecondaryColor, 
          cursorColor: kSecondaryColor, 
          validator: (value) {
            Uri? uri = Uri.tryParse(value!);
            return (uri?.host == 'www.whatsapp.com' || uri?.host == 'whatsapp.com')
              ? null 
              : 'Enter a valid WhatsApp URL';
          },
        ),

        if (widget.selectedLink == SocialLinks.Instagram) URLTextField(
          hintText: 'Instagram',
          textColor: kSecondaryColor,
          icon: FontAwesomeIcons.instagram,
          onChanged: (value) {
            setState(() {
              widget.link = value!;
            });
          }, 
          enabledBorderColor: kFontTheme(context), 
          focusedBorderColor: kSecondaryColor, 
          errorBorderColor: kRedColor, 
          focusedErrorBorderColor: kRedColor, 
          errorTextStyleColor: kRedColor, 
          iconColor: kSecondaryColor, 
          cursorColor: kSecondaryColor, 
          validator: (value) {
            Uri? uri = Uri.tryParse(value!);
            return (uri?.host == 'www.instagram.com' || uri?.host == 'instagram.com')
              ? null 
              : 'Enter a valid Instagram URL';
          },
        ),

        if (widget.selectedLink == SocialLinks.XTwitter) URLTextField(
          hintText: 'XTwitter',
          textColor: kSecondaryColor,
          icon: FontAwesomeIcons.xTwitter,
          onChanged: (value) {
            setState(() {
              widget.link = value!;
            });
          }, 
          enabledBorderColor: kFontTheme(context), 
          focusedBorderColor: kSecondaryColor, 
          errorBorderColor: kRedColor, 
          focusedErrorBorderColor: kRedColor, 
          errorTextStyleColor: kRedColor, 
          iconColor: kSecondaryColor, 
          cursorColor: kSecondaryColor, 
          validator: (value) {
            Uri? uri = Uri.tryParse(value!);
            return (uri?.host == 'www.twitter.com' || uri?.host == 'twitter.com')
              ? null 
              : 'Enter a valid XTwitter URL';
          },
        ),

        if (widget.selectedLink == SocialLinks.Facebook) URLTextField(
          hintText: 'Facebook',
          textColor: kSecondaryColor,
          icon: FontAwesomeIcons.facebook,
          onChanged: (value) {
            setState(() {
              widget.link = value!;
            });
          }, 
          enabledBorderColor: kFontTheme(context), 
          focusedBorderColor: kSecondaryColor, 
          errorBorderColor: kRedColor, 
          focusedErrorBorderColor: kRedColor, 
          errorTextStyleColor: kRedColor, 
          iconColor: kSecondaryColor, 
          cursorColor: kSecondaryColor, 
          validator: (value) {
            Uri? uri = Uri.tryParse(value!);
            return (uri?.host == 'www.facebook.com' || uri?.host == 'facebook.com')
              ? null 
              : 'Enter a valid Facebook URL';
          },
        ),

        if (widget.selectedLink == SocialLinks.LinkedIn) URLTextField(
          hintText: 'LinkedIn',
          textColor: kSecondaryColor,
          icon: FontAwesomeIcons.linkedin,
          onChanged: (value) {
            setState(() {
              widget.link = value!;
            });
          }, 
          enabledBorderColor: kFontTheme(context), 
          focusedBorderColor: kSecondaryColor, 
          errorBorderColor: kRedColor, 
          focusedErrorBorderColor: kRedColor, 
          errorTextStyleColor: kRedColor, 
          iconColor: kSecondaryColor, 
          cursorColor: kSecondaryColor, 
          validator: (value) {
            Uri? uri = Uri.tryParse(value!);
            return (uri?.host == 'www.linkedin.com' || uri?.host == 'linkedin.com')
              ? null 
              : 'Enter a valid Linkedin URL';
          },
        ),

        if (widget.selectedLink == SocialLinks.YouTube) URLTextField(
          hintText: 'YouTube',
          textColor: kSecondaryColor,
          icon: FontAwesomeIcons.youtube,
          onChanged: (value) {
            setState(() {
              widget.link = value!;
            });
          }, 
          enabledBorderColor: kFontTheme(context), 
          focusedBorderColor: kSecondaryColor, 
          errorBorderColor: kRedColor, 
          focusedErrorBorderColor: kRedColor, 
          errorTextStyleColor: kRedColor, 
          iconColor: kSecondaryColor, 
          cursorColor: kSecondaryColor, 
          validator: (value) {
            Uri? uri = Uri.tryParse(value!);
            return (uri?.host == 'www.youtube.com' || uri?.host == 'youtube.com')
              ? null 
              : 'Enter a valid Youtube URL';
          },
        ),

        if (widget.selectedLink == SocialLinks.Other) URLTextField(
          hintText: 'Other',
          textColor: kSecondaryColor,
          onChanged: (value) {
            setState(() {
              widget.link = value!;
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
      ].animate(
        interval: kAnimationDurationMs(100),
        effects: MyEffects.fadeSlide(offset: const Offset(-0.05, 0)),
      ),
    );
  }
}
