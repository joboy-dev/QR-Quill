// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_quill/models/qrcode_model.dart';
import 'package:qr_quill/screens/create/forms/contact.dart';
import 'package:qr_quill/screens/create/forms/email.dart';
import 'package:qr_quill/screens/create/forms/event.dart';
import 'package:qr_quill/screens/create/forms/file.dart';
import 'package:qr_quill/screens/create/forms/image.dart';
import 'package:qr_quill/screens/create/forms/socials.dart';
import 'package:qr_quill/screens/create/forms/text.dart';
import 'package:qr_quill/screens/create/forms/url.dart';
import 'package:qr_quill/screens/create/forms/wifi.dart';
import 'package:qr_quill/shared/animations.dart';
import 'package:qr_quill/shared/button.dart';
import 'package:qr_quill/shared/constants.dart';
import 'package:qr_quill/shared/snackbar.dart';
import 'package:qr_quill/shared/textfield.dart';

class CreateQRCode extends StatefulWidget {
  const CreateQRCode({super.key});

  static const String id = 'create_qrrcode';

  @override
  State<CreateQRCode> createState() => _CreateQRCodeState();
}

class _CreateQRCodeState extends State<CreateQRCode> {
  double extraFieldsHeight = 0.0;

  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  String message = '';

  String type = 'QR Code';
  String title = '';
  Category? selectedCategory;

  // Wifi
  String wifiName = '';
  String widiPassword = '';

  // Email
  String email = '';

  // Text
  String text = '';

  // URL
  String url = '';

  // Contact
  String fullName = '';
  String phoneNumber = '';
  String address = '';
  // email already present

  // Event
  String eventTitle = '';
  String eventLocation = '';
  DateTime? startDate;
  DateTime? endDate;
  TimeOfDay? startTime;
  TimeOfDay? endTime;

  // Image
  String? mediaPath;

  // File
  String? filePath;

  // Socials
  SocialLinks? selectedLink;
  String socialLink = '';

  validateForm() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
        message = 'Generating QR Code...';
      });

    } else {
      setState(() {
        message = 'Field validation check failed.';
      });

    }
    showSnackbar(context, message);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: kAppPadding,
            child: Form(
              key: _formKey,
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.end,sss
                children: [
                  NormalTextField(
                    initialValue: 'QR Code',
                    readonly: true,
                    hintText: 'Type', 
                    onChanged: (value) {
                      setState(() {
                        type = value!;
                      });
                    }, 
                    enabledBorderColor: kFontTheme(context), 
                    focusedBorderColor: kFontTheme(context), 
                    errorBorderColor: kRedColor, 
                    focusedErrorBorderColor: kRedColor, 
                    errorTextStyleColor: kRedColor, 
                    iconColor: kSecondaryColor, 
                    cursorColor: kSecondaryColor, 
                    prefixIcon: Icons.qr_code,
                  ),

                  NormalTextField(
                    hintText: 'Title for QR Code',
                    textColor: kSecondaryColor,
                    onChanged: (value) {
                      setState(() {
                        title = value!;
                      });
                    }, 
                    enabledBorderColor: kFontTheme(context), 
                    focusedBorderColor: kSecondaryColor, 
                    errorBorderColor: kRedColor, 
                    focusedErrorBorderColor: kRedColor, 
                    errorTextStyleColor: kRedColor, 
                    iconColor: kSecondaryColor, 
                    cursorColor: kSecondaryColor, 
                    prefixIcon: Icons.title,
                  ),

                  DropDownFormField(
                    value: selectedCategory,
                    items: Category.values
                      .map(
                        (category) => DropdownMenuItem(
                          value: category,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                category.name,
                                style: kNormalTextStyle.copyWith(fontSize: 15.sp),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                child: Icon(
                                  categoryIcons[category],
                                  size: 15.r,
                                  color: kSecondaryColor,
                                ),
                              ),
                            ].animate(
                              interval: kAnimationDurationMs(1000),
                              effects: MyEffects.slideShake(),
                            ),
                          ),
                        ),
                      )
                    .toList(),
                    enabledBorderColor: kFontTheme(context), 
                    focusedBorderColor: kSecondaryColor, 
                    errorBorderColor: kRedColor, 
                    focusedErrorBorderColor: kRedColor, 
                    errorTextStyleColor: kRedColor, 
                    iconColor: kSecondaryColor, 
                    prefixIcon: Icons.category,
                    onChanged: (value) {
                      setState(() {
                        selectedCategory = value!;
                        print('Seledted Category: ${selectedCategory?.name}');
                      });
                    },
                  ),
                  
                  // CATEGORY SPECIFIC FORM FIELDS
                  selectedCategory != null ? Column(
                    children: [
                      Divider(color: kTertiaryColor, thickness: 0.2.sp),
                      SizedBox(height: 20.h),
                  
                      if (selectedCategory?.name == 'Wifi') WifiForm(wifiName: wifiName, widiPassword: widiPassword,),
                      if (selectedCategory?.name == 'Text') TextForm(text: text,),
                      if (selectedCategory?.name == 'Email') EmailForm(email: email,),
                      if (selectedCategory?.name == 'URL') URLForm(url: url,),
                      if (selectedCategory?.name == 'Contact') ContactForm(
                        fullname: fullName,
                        phoneNumber: phoneNumber,
                        address: address,
                        email: email,
                      ),
                      if (selectedCategory?.name == 'Socials') SocialsForm(selectedLink: selectedLink, link: socialLink),
                      if (selectedCategory?.name == 'Image') ImageUploadForm(mediaPath: mediaPath,),
                      if (selectedCategory?.name == 'File') FileUploadForm(filePath: filePath,),
                      if (selectedCategory?.name == 'Event') EventForm(
                        eventTitle: eventTitle, 
                        eventLocation: eventLocation, 
                        startDate: startDate, 
                        endDate: endDate, startTime: 
                        startTime, 
                        endTime: endTime
                      ),
                      
                      const SizedBox(height: 10.0),
                  
                      Button(
                        buttonColor: kSecondaryColor,
                        buttonText: 'Generate QR Code',
                        onPressed: () {
                          validateForm();
                        },
                        inactive: false,
                      ),
                      const SizedBox(height: 20.0),
                    ].animate(
                      interval: kAnimationDurationMs(100),
                      effects: MyEffects.fadeSlide(),
                    ),
                  ) : const SizedBox(height: 0),
                ].animate(
                  interval: kAnimationDurationMs(100),
                  effects: MyEffects.fadeSlide(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

