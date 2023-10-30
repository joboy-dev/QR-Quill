// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qr_quill/models/create_model.dart';
import 'package:qr_quill/shared/animations.dart';
import 'package:qr_quill/shared/button.dart';
import 'package:qr_quill/shared/constants.dart';
import 'package:qr_quill/shared/snackbar.dart';
import 'package:qr_quill/shared/textfield.dart';

class CreateBarcode extends StatefulWidget {
  const CreateBarcode({super.key});

  static const String id = 'create_qrrcode';

  @override
  State<CreateBarcode> createState() => _CreateBarcodeState();
}

class _CreateBarcodeState extends State<CreateBarcode> {
  double extraFieldsHeight = 0.0;

  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  String message = '';

  String type = 'Barcode';
  String barcodeName = '';
  Category? selectedCategory;
  DateTime created = DateTime.now();

  validateForm() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
        message = 'Generating Barcode...';
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
            padding: kAppPadding(),
            child: Form(
              key: _formKey,
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.end,sss
                children: [
                  NormalTextField(
                    initialValue: 'Barcode',
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
                    prefixIcon: FontAwesomeIcons.barcode,
                  ),

                  NormalTextField(
                    hintText: 'Barcode Name',
                    textColor: kSecondaryColor,
                    onChanged: (value) {
                      setState(() {
                        barcodeName = value!;
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
                      
                      SizedBox(height: 10.h),
                  
                      Button(
                        buttonColor: kSecondaryColor,
                        buttonText: 'Generate Barcode',
                        onPressed: () {
                          validateForm();
                        },
                        inactive: false,
                      ),
                      SizedBox(height: 20.h),
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

