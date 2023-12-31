// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_quill/models/create_code.dart';
import 'package:qr_quill/screens/create/qr_code/qr_forms/contact.dart';
import 'package:qr_quill/screens/create/qr_code/qr_forms/email.dart';
import 'package:qr_quill/screens/create/qr_code/qr_forms/event.dart';
import 'package:qr_quill/screens/create/qr_code/qr_forms/file.dart';
import 'package:qr_quill/screens/create/qr_code/qr_forms/image.dart';
import 'package:qr_quill/screens/create/qr_code/qr_forms/sms.dart';
import 'package:qr_quill/screens/create/qr_code/qr_forms/socials.dart';
import 'package:qr_quill/screens/create/qr_code/qr_forms/text.dart';
import 'package:qr_quill/screens/create/qr_code/qr_forms/url.dart';
import 'package:qr_quill/screens/create/qr_code/qr_forms/wifi.dart';
import 'package:qr_quill/shared/animations.dart';
import 'package:qr_quill/shared/constants.dart';
import 'package:qr_quill/shared/logger.dart';
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

  // DATA FOR QR CODE
  String? data;

  String type = 'QR Code';
  String? qrCodeName;
  QRCodeCategory? selectedCategory;
  DateTime created = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: kAppPadding(),
            child: Form(
              key: _formKey,
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.end,
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
                    hintText: 'QR Code Name (Optional)',
                    labelText: 'QR Code Name',
                    textColor: kSecondaryColor,
                    onChanged: (value) {
                      setState(() {
                        qrCodeName = value!;
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
                    items: QRCodeCategory.values
                      .map(
                        (category) => DropdownMenuItem(
                          value: category,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                category.name,
                                style: kYellowNormalTextStyle(context).copyWith(fontSize: 15.sp),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.r),
                                child: Icon(
                                  qrCodeCategoryStringDataIcons[category.name],
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
                        logger('Seledted Category: ${selectedCategory?.name}');
                      });
                    }
                  ),
                  
                  // CATEGORY SPECIFIC FORM FIELDS
                  selectedCategory != null ? Column(
                    children: [
                      Divider(color: kTertiaryColor, thickness: 0.2.sp),
                      SizedBox(height: 20.h),
                  
                      if (selectedCategory?.name == 'Wifi') WifiForm(qrCodeName: qrCodeName ?? selectedCategory!.name),
                      if (selectedCategory?.name == 'Text') TextForm(qrCodeName: qrCodeName ?? selectedCategory!.name),
                      if (selectedCategory?.name == 'Email') EmailForm(qrCodeName: qrCodeName ?? selectedCategory!.name,),
                      if (selectedCategory?.name == 'URL') URLForm(qrCodeName: qrCodeName ?? selectedCategory!.name,),
                      if (selectedCategory?.name == 'Contact') ContactForm(qrCodeName: qrCodeName ?? selectedCategory!.name,),
                      if (selectedCategory?.name == 'Socials') SocialsForm(qrCodeName: qrCodeName ?? selectedCategory!.name,),
                      if (selectedCategory?.name == 'SMS') SMSForm(qrCodeName: qrCodeName ?? selectedCategory!.name,),
                      if (selectedCategory?.name == 'Event') EventForm(qrCodeName: qrCodeName ?? selectedCategory!.name),
                      if (selectedCategory?.name == 'Image') ImageForm(qrCodeName: qrCodeName ?? selectedCategory!.name),
                      if (selectedCategory?.name == 'File') FileForm(qrCodeName: qrCodeName ?? selectedCategory!.name),
                      
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

