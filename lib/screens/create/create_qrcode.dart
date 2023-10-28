// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qr_quill/models/qrcode_model.dart';
import 'package:qr_quill/screens/create/forms/contact.dart';
import 'package:qr_quill/screens/create/forms/email.dart';
import 'package:qr_quill/screens/create/forms/event.dart';
import 'package:qr_quill/screens/create/forms/sms.dart';
import 'package:qr_quill/screens/create/forms/socials.dart';
import 'package:qr_quill/screens/create/forms/text.dart';
import 'package:qr_quill/screens/create/forms/url.dart';
import 'package:qr_quill/screens/create/forms/wifi.dart';
import 'package:qr_quill/screens/create/show_qrcode.dart';
import 'package:qr_quill/services/cloud_storage.dart';
import 'package:qr_quill/shared/animations.dart';
import 'package:qr_quill/shared/button.dart';
import 'package:qr_quill/shared/constants.dart';
import 'package:qr_quill/shared/logger.dart';
import 'package:qr_quill/shared/navigator.dart';
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

  // DATA FOR QR CODE
  String? data;

  String type = 'QR Code';
  String? qrCodeName;
  Category? selectedCategory;
  DateTime created = DateTime.now();

  // Image
  String? mediaPath;
  XFile? pickedMedia;

  // File
  String? filePath;
  FilePickerResult? pickedFile;

  // Socials
  SocialLinks? selectedLink;
  String socialLink = '';

  final cloudStorage = CloudStorage();

  /// Function to pick an image
  pickImage() async {
    final imagePicker = ImagePicker();
                                              
    setState(() {
      pickedMedia = null;
    });

    // pick image from file system
    pickedMedia = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedMedia != null) {
      setState(() {
        mediaPath = pickedMedia!.path;
      });
      logger('Selected Image Path: $mediaPath');
      logger('Picked Media: $pickedMedia');
    }
  }

  /// Function to pick a file
  pickFile() async {
    final filePicker = FilePicker.platform;

    setState(() {
      pickedFile = null;
    });

    // pick image from file system
    pickedFile = await filePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx', 'ppt', 'pptx', 'svg', 'xlsx', 'xls', 'zip', 'rar', 'txt'],
    );

    if (pickedFile != null) {
      File file = File(pickedFile!.files.single.path!);
      setState(() {
        filePath = file.path;
      });

      logger('Selected File Path: $filePath');
      logger('Selected File: $pickedFile');
    }
  }

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
                    hintText: 'QR Code Name',
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
                    items: Category.values
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
                      
                      // Image Upload
                      if (selectedCategory?.name == 'Image') Column(
                        children: [
                          Text(
                            'Please ensure you have an Internet Connection', 
                            style: kYellowNormalTextStyle(context).copyWith(
                              fontSize: 17.0,
                            )
                          ),
                          SizedBox(height: 10.h),
                          MediaUploadField(
                            mediaPath: mediaPath, 
                            pickImage: pickImage
                          ),
                          Button(
                            buttonColor: kSecondaryColor,
                            buttonText: 'Generate QR Code',
                            onPressed: () async {
                              if (pickedMedia != null) {
                                showSnackbar(context, 'Generating Qr Code...');
                                String downloadUrl = await cloudStorage.uploadImage(pickedMedia);
                                logger(downloadUrl);

                                navigatorPush(context, ShowQRCode(
                                    qrCodeName: qrCodeName ?? selectedCategory!.name, 
                                    selectedCategory: selectedCategory!, 
                                    qrData: downloadUrl, 
                                    stringData: downloadUrl,
                                  )
                                );
                              } else {
                                showSnackbar(context, 'Please select an image');
                              }
                            },
                            inactive: false,
                          ),
                          SizedBox(height:10.h),
                        ].animate(
                          interval: kAnimationDurationMs(100),
                          effects: MyEffects.fadeSlide(),
                        ),
                      ),

                      // File Upload
                      if (selectedCategory?.name == 'File') Column(
                        children: [
                          Text(
                            'Please ensure you have an Internet Connection', 
                            style: kYellowNormalTextStyle(context).copyWith(
                              fontSize: 17.0,
                            )
                          ),
                          SizedBox(height: 10.h),
                          FileUploadField(
                            filePath: filePath,
                            pickFile: pickFile,
                          ),
                          Button(
                            buttonColor: kSecondaryColor,
                            buttonText: 'Generate QR Code',
                            onPressed: () async {
                              if (pickedFile != null) {
                                showSnackbar(context, 'Generating Qr Code...');
                                String downloadUrl = await cloudStorage.uploadFile(pickedFile);
                                logger(downloadUrl);

                                navigatorPush(context, ShowQRCode(
                                    qrCodeName: qrCodeName ?? selectedCategory!.name, 
                                    selectedCategory: selectedCategory!, 
                                    qrData: downloadUrl, 
                                    stringData: downloadUrl,
                                  )
                                );
                              } else {
                                showSnackbar(context, 'Please select a file');
                              }
                            },
                            inactive: false,
                          ),
                          SizedBox(height:10.h),
                        ].animate(
                          interval: kAnimationDurationMs(100),
                          effects: MyEffects.fadeSlide(),
                        ),
                      ),
                    ].animate(
                      interval: kAnimationDurationMs(100),
                      effects: MyEffects.fadeSlide(),
                    ),
                  ) : const SizedBox(height: 0),

                  // QR Code picture
                  
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

