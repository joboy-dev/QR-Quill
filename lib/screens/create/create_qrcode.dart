// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:qr_quill/models/qrcode_model.dart';
import 'package:qr_quill/screens/create/forms/contact.dart';
import 'package:qr_quill/screens/create/forms/email.dart';
import 'package:qr_quill/screens/create/forms/event.dart';
import 'package:qr_quill/screens/create/forms/file.dart';
import 'package:qr_quill/screens/create/forms/image.dart';
import 'package:qr_quill/screens/create/forms/text.dart';
import 'package:qr_quill/screens/create/forms/url.dart';
import 'package:qr_quill/screens/create/forms/wifi.dart';
import 'package:qr_quill/shared/button.dart';
import 'package:qr_quill/shared/constants.dart';
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

  String type = 'QR Code';
  String title = '';
  Category? selectedCategory;

  // EVENT FORM
  String eventTitle = '';
  String eventLocation = '';
  DateTime? startDate;
  DateTime? endDate;
  TimeOfDay? startTime;
  TimeOfDay? endTime;

  validateForm() {
    if (_formKey.currentState!.validate()) {

    } else {

    }
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
                                style: kNormalTextStyle,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                child: Icon(
                                  categoryIcons[category],
                                  size: 20.0,
                                  color: kSecondaryColor,
                                ),
                              ),
                            ],
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
                        extraFieldsHeight = value == null ? 0.0 : kHeightWidth(context).height * 0.6;
                      });
                    },
                  ),
                  
                  // CATEGORY SPECIFIC FORM FIELDS
                  selectedCategory != null ? AnimatedContainer(
                    duration: kAnimationDuration5,
                    curve: Curves.easeIn,
                    height: extraFieldsHeight,
                    child: Column(
                      children: [
                        Divider(color: kTertiaryColor, thickness: 0.2),
                        const SizedBox(height: 20.0),
                  
                        if (selectedCategory?.name == 'Wifi') const WifiForm(),
                        if (selectedCategory?.name == 'Text') const TextForm(),
                        if (selectedCategory?.name == 'Email') const EmailForm(),
                        if (selectedCategory?.name == 'URL') const URLForm(),
                        if (selectedCategory?.name == 'Contact') const ContactForm(),
                        if (selectedCategory?.name == 'Image') const ImageUploadForm(),
                        if (selectedCategory?.name == 'File') const FileUploadForm(),
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
                      ],
                    ),
                  ) : const SizedBox(height: 0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
