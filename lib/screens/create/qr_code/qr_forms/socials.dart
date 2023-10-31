// ignore_for_file: constant_identifier_names, must_be_immutable, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qr_quill/models/create_code.dart';
import 'package:qr_quill/screens/create/qr_code/create_qr_results.dart';
import 'package:qr_quill/services/isar_db.dart';
import 'package:qr_quill/shared/animations.dart';
import 'package:qr_quill/shared/button.dart';
import 'package:qr_quill/shared/constants.dart';
import 'package:qr_quill/shared/logger.dart';
import 'package:qr_quill/shared/navigator.dart';
import 'package:qr_quill/shared/snackbar.dart';
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
  SocialsForm({super.key, required this.qrCodeName});

  String qrCodeName;

  @override
  State<SocialsForm> createState() => _SocialsFormState();
}

class _SocialsFormState extends State<SocialsForm> with SingleTickerProviderStateMixin {
  SocialLinks? selectedLink;

  String link = '';

  final _formKey = GlobalKey<FormState>();
  bool obscureText = true;
  bool isLoading = false;

  String stringData = '';
  final isarDb = IsarDB();
  final dateGenerated = DateTime.now().toString().substring(0, 16);

  validateForm() async {
    if (_formKey.currentState!.validate()) {
      logger(link);

      // Collect all data
      stringData = '${selectedLink?.name} Link:\n$link';

      showSnackbar(context, 'Generating QR Code...');
      setState(() {
        isLoading = true;
      });

      await Future.delayed(kAnimationDuration2);
      navigatorPushReplacement(context, ShowQRCode(
        qrData: link,
        stringData: stringData,
        qrCodeName: widget.qrCodeName,
        selectedCategory: QRCodeCategory.Socials.name,
        dateGenerated: dateGenerated,
        )
      );

      await isarDb.addCreatedCode(
        context, 
        CreateCode(
          type: 'QR Code',
          codeName: widget.qrCodeName,
          category: QRCodeCategory.Socials.name,
          codeData: link,
          stringData: stringData,
          datetime: dateGenerated,
        ),
      );
    } else {
      showSnackbar(context, 'Field validation failed. Ensure all fields are valid.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          DropDownFormField(
            labelText: 'Choose',
            value: selectedLink, 
            items: SocialLinks.values
              .map(
                (link) => DropdownMenuItem(
                  value: link,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        link.name,
                        style: kYellowNormalTextStyle(context).copyWith(fontSize: 15.sp),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.r),
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
                selectedLink = value;
              });
             logger('Selected Link: ${selectedLink!.name}');
            }, 
            prefixIcon: Icons.link, 
            iconColor: kSecondaryColor, 
            enabledBorderColor: kFontTheme(context), 
            focusedBorderColor: kSecondaryColor, 
            errorBorderColor: kRedColor, 
            focusedErrorBorderColor: kRedColor, 
            errorTextStyleColor: kRedColor, 
          ),
    
          if (selectedLink == SocialLinks.WhatsApp) URLTextField(
            hintText: 'WhatsApp',
            textColor: kSecondaryColor,
            icon: FontAwesomeIcons.whatsapp,
            onChanged: (value) {
              setState(() {
                link = value!;
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
              return (uri?.host == 'www.whatsapp.com' || uri?.host == 'whatsapp.com' || uri?.host == 'wa.me')
                ? null 
                : 'Enter a valid WhatsApp URL';
            },
          ),
    
          if (selectedLink == SocialLinks.Instagram) URLTextField(
            hintText: 'Instagram',
            textColor: kSecondaryColor,
            icon: FontAwesomeIcons.instagram,
            onChanged: (value) {
              setState(() {
                link = value!;
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
    
          if (selectedLink == SocialLinks.XTwitter) URLTextField(
            hintText: 'XTwitter',
            textColor: kSecondaryColor,
            icon: FontAwesomeIcons.xTwitter,
            onChanged: (value) {
              setState(() {
                link = value!;
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
    
          if (selectedLink == SocialLinks.Facebook) URLTextField(
            hintText: 'Facebook',
            textColor: kSecondaryColor,
            icon: FontAwesomeIcons.facebook,
            onChanged: (value) {
              setState(() {
                link = value!;
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
    
          if (selectedLink == SocialLinks.LinkedIn) URLTextField(
            hintText: 'LinkedIn',
            textColor: kSecondaryColor,
            icon: FontAwesomeIcons.linkedin,
            onChanged: (value) {
              setState(() {
                link = value!;
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
    
          if (selectedLink == SocialLinks.YouTube) URLTextField(
            hintText: 'YouTube',
            textColor: kSecondaryColor,
            icon: FontAwesomeIcons.youtube,
            onChanged: (value) {
              setState(() {
                link = value!;
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
    
          if (selectedLink == SocialLinks.Other) URLTextField(
            hintText: 'Other',
            textColor: kSecondaryColor,
            onChanged: (value) {
              setState(() {
                link = value!;
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

          Button(
            buttonColor: kSecondaryColor,
            buttonText: 'Generate QR Code',
            onPressed: () {
              validateForm();
            },
            inactive: false,
          ),
          SizedBox(height:10.h),
        ].animate(
          interval: kAnimationDurationMs(100),
          effects: MyEffects.fadeSlide(offset: const Offset(-0.05, 0)),
        ),
      ),
    );
  }
}
