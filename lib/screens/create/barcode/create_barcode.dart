// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qr_quill/models/create_code.dart';
import 'package:qr_quill/screens/create/barcode/barcode_forms.dart';
import 'package:qr_quill/shared/animations.dart';
import 'package:qr_quill/shared/constants.dart';
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

  String type = 'Barcode';
  String? barcodeName;
  BarcodeCategory? selectedCategory;

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
                    hintText: 'Barcode Name (Optional)',
                    labelText: 'Barcode Name',
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
                    items: BarcodeCategory.values
                      .map(
                        (category) => DropdownMenuItem(
                          value: category,
                          child: Text(
                            category.name,
                            style: kYellowNormalTextStyle(context).copyWith(fontSize: 15.sp),
                          ).animate(
                              effects: MyEffects.slideShake(),
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
                      BarcodeForms(barcodeCategory: selectedCategory!, barcodeName: barcodeName ?? selectedCategory!.name,),
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

