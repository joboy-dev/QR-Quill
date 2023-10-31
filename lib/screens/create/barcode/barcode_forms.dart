// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qr_quill/models/create_code.dart';
import 'package:qr_quill/screens/create/barcode/create_barcode_results.dart';
import 'package:qr_quill/services/isar_db.dart';
import 'package:qr_quill/shared/button.dart';
import 'package:qr_quill/shared/constants.dart';
import 'package:qr_quill/shared/logger.dart';
import 'package:qr_quill/shared/navigator.dart';
import 'package:qr_quill/shared/snackbar.dart';
import 'package:qr_quill/shared/textfield.dart';

class BarcodeForms extends StatefulWidget {
  const BarcodeForms({super.key, required this.barcodeCategory, required this.barcodeName});

  final BarcodeCategory barcodeCategory;
  final String barcodeName;

  @override
  State<BarcodeForms> createState() => _BarcodeFormsState();
}

class _BarcodeFormsState extends State<BarcodeForms> {
  final _formKey = GlobalKey<FormState>();
  String barcodeData = '';

  final isarDb = IsarDB();
  final dateGenerated = DateTime.now().toString().substring(0, 16);

  // Function to validate fields that requires max number of numbers
  String? digitValidator(String? value, int maxDigits) {
    if (value!.length > maxDigits) {
      return 'Only $maxDigits digits are allowed';
    } else if (value.length < maxDigits) {
      return '$maxDigits digits are required';
    } else {
      return null;
    }
  }

  validateForm() async {
    if (_formKey.currentState!.validate()) {
      showSnackbar(context, 'Generating QR Code');

      logger('Barcode Text: $barcodeData');
      logger('Barcode Name: ${widget.barcodeName}');

      navigatorPushReplacement(
        context,
        ShowBarcode(
          barcodeName: widget.barcodeName, 
          selectedCategory: widget.barcodeCategory.name, 
          barcodeData: barcodeData,
          dateScanned: dateGenerated,
        )
      );

      await isarDb.addCreatedCode(
        context, 
        CreateCode(
          type: 'Barcode',
          category: widget.barcodeCategory.name,
          codeName: widget.barcodeName,
          codeData: barcodeData,
          stringData: barcodeData,
          datetime: dateGenerated,
        )
      );
    } else {
      showSnackbar(context, 'Field validation checks failed. Ensure all fields are valid.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          if (widget.barcodeCategory == BarcodeCategory.QRCode || 
          widget.barcodeCategory == BarcodeCategory.PDF417) TextareaTextField(
            hintText: 'Enter Text', 
            onChanged: (value) {
              setState(() {
                barcodeData = value!;
              });
            }, 
            enabledBorderColor: kFontTheme(context), 
            focusedBorderColor: kSecondaryColor, 
            errorBorderColor: kRedColor, 
            focusedErrorBorderColor: kRedColor, 
            errorTextStyleColor: kRedColor, 
            cursorColor: kSecondaryColor, 
          ),

          if (widget.barcodeCategory == BarcodeCategory.DataMatrix || 
          widget.barcodeCategory == BarcodeCategory.Aztec ||
          widget.barcodeCategory == BarcodeCategory.Code128) TextareaTextField(
            hintText: 'Text without special characters', 
            onChanged: (value) {
              setState(() {
                barcodeData = value!;
              });
            }, 
            validator: (value) {
              // check against special characters
              if (RegExp(r'[^\w\d\s]').hasMatch(value!)) {
                return 'No special characters allowed';
              } else if(value.isEmpty) {
                return 'This field cannot be empty';
              } else {
                return null;
              }
            },
            enabledBorderColor: kFontTheme(context), 
            focusedBorderColor: kSecondaryColor, 
            errorBorderColor: kRedColor, 
            focusedErrorBorderColor: kRedColor, 
            errorTextStyleColor: kRedColor, 
            cursorColor: kSecondaryColor, 
          ),

          if (widget.barcodeCategory == BarcodeCategory.EAN13) NormalTextField(
            hintText: 'EAN 13',
            textColor: kSecondaryColor,
            textInputType: TextInputType.number,
            onChanged: (value) {
              setState(() {
                barcodeData = value!;
              });
            }, 
            enabledBorderColor: kFontTheme(context), 
            focusedBorderColor: kSecondaryColor, 
            errorBorderColor: kRedColor, 
            focusedErrorBorderColor: kRedColor, 
            errorTextStyleColor: kRedColor, 
            iconColor: kSecondaryColor, 
            cursorColor: kSecondaryColor, 
            prefixIcon: FontAwesomeIcons.barcode,
            validator: (value) {
              return digitValidator(value, 12);
            },
          ),

          if (widget.barcodeCategory == BarcodeCategory.EAN8) NormalTextField(
            hintText: 'EAN 8',
            textColor: kSecondaryColor,
            textInputType: TextInputType.number,
            onChanged: (value) {
              setState(() {
                barcodeData = value!;
              });
            }, 
            enabledBorderColor: kFontTheme(context), 
            focusedBorderColor: kSecondaryColor, 
            errorBorderColor: kRedColor, 
            focusedErrorBorderColor: kRedColor, 
            errorTextStyleColor: kRedColor, 
            iconColor: kSecondaryColor, 
            cursorColor: kSecondaryColor, 
            prefixIcon: FontAwesomeIcons.barcode,
            validator: (value) {
              return digitValidator(value, 7);
            },
          ),

          if (widget.barcodeCategory == BarcodeCategory.EAN5) NormalTextField(
            hintText: 'EAN 5',
            textColor: kSecondaryColor,
            textInputType: TextInputType.number,
            onChanged: (value) {
              setState(() {
                barcodeData = value!;
              });
            }, 
            enabledBorderColor: kFontTheme(context), 
            focusedBorderColor: kSecondaryColor, 
            errorBorderColor: kRedColor, 
            focusedErrorBorderColor: kRedColor, 
            errorTextStyleColor: kRedColor, 
            iconColor: kSecondaryColor, 
            cursorColor: kSecondaryColor, 
            prefixIcon: FontAwesomeIcons.barcode,
            validator: (value) {
              return digitValidator(value, 5);
            },
          ),

          if (widget.barcodeCategory == BarcodeCategory.EAN2) NormalTextField(
            hintText: 'EAN 2',
            textColor: kSecondaryColor,
            textInputType: TextInputType.number,
            onChanged: (value) {
              setState(() {
                barcodeData = value!;
              });
            }, 
            enabledBorderColor: kFontTheme(context), 
            focusedBorderColor: kSecondaryColor, 
            errorBorderColor: kRedColor, 
            focusedErrorBorderColor: kRedColor, 
            errorTextStyleColor: kRedColor, 
            iconColor: kSecondaryColor, 
            cursorColor: kSecondaryColor, 
            prefixIcon: FontAwesomeIcons.barcode,
            validator: (value) {
              return digitValidator(value, 2);
            },
          ),

          if (widget.barcodeCategory == BarcodeCategory.UPC_A) NormalTextField(
            hintText: 'UPC A',
            textColor: kSecondaryColor,
            textInputType: TextInputType.number,
            onChanged: (value) {
              setState(() {
                barcodeData = value!;
              });
            }, 
            enabledBorderColor: kFontTheme(context), 
            focusedBorderColor: kSecondaryColor, 
            errorBorderColor: kRedColor, 
            focusedErrorBorderColor: kRedColor, 
            errorTextStyleColor: kRedColor, 
            iconColor: kSecondaryColor, 
            cursorColor: kSecondaryColor, 
            prefixIcon: FontAwesomeIcons.barcode,
            validator: (value) {
              return digitValidator(value, 11);
            },
          ),

          if (widget.barcodeCategory == BarcodeCategory.UPC_E) NormalTextField(
            hintText: 'UPC E',
            textColor: kSecondaryColor,
            textInputType: TextInputType.number,
            onChanged: (value) {
              setState(() {
                barcodeData = value!;
              });
            }, 
            enabledBorderColor: kFontTheme(context), 
            focusedBorderColor: kSecondaryColor, 
            errorBorderColor: kRedColor, 
            focusedErrorBorderColor: kRedColor, 
            errorTextStyleColor: kRedColor, 
            iconColor: kSecondaryColor, 
            cursorColor: kSecondaryColor, 
            prefixIcon: FontAwesomeIcons.barcode,
            validator: (value) {
              return digitValidator(value, 7);
            },
          ),

          if (widget.barcodeCategory == BarcodeCategory.ISBN) NormalTextField(
            hintText: 'ISBN',
            textColor: kSecondaryColor,
            textInputType: TextInputType.number,
            onChanged: (value) {
              setState(() {
                barcodeData = value!;
              });
            }, 
            enabledBorderColor: kFontTheme(context), 
            focusedBorderColor: kSecondaryColor, 
            errorBorderColor: kRedColor, 
            focusedErrorBorderColor: kRedColor, 
            errorTextStyleColor: kRedColor, 
            iconColor: kSecondaryColor, 
            cursorColor: kSecondaryColor, 
            prefixIcon: FontAwesomeIcons.barcode,
            validator: (value) {
              return digitValidator(value, 12);
            },
          ),

          if (widget.barcodeCategory == BarcodeCategory.Code39 || 
          widget.barcodeCategory == BarcodeCategory.Code93) NormalTextField(
            hintText: 'Text in uppercase without special characters',
            textColor: kSecondaryColor,
            onChanged: (value) {
              setState(() {
                barcodeData = value!.toUpperCase();
              });
            }, 
            enabledBorderColor: kFontTheme(context), 
            focusedBorderColor: kSecondaryColor, 
            errorBorderColor: kRedColor, 
            focusedErrorBorderColor: kRedColor, 
            errorTextStyleColor: kRedColor, 
            iconColor: kSecondaryColor, 
            cursorColor: kSecondaryColor, 
            prefixIcon: FontAwesomeIcons.barcode,
            validator: (value) {
              // check against special characters
              if (RegExp(r'[^\w\d\s]').hasMatch(value!)) {
                return 'No special characters allowed';
              } else if(value.isEmpty) {
                return 'This field cannot be empty';
              } else {
                return null;
              }
            },
          ),

          if (widget.barcodeCategory == BarcodeCategory.Codabar) NormalTextField(
            hintText: 'Codabar',
            textColor: kSecondaryColor,
            textInputType: TextInputType.number,
            onChanged: (value) {
              setState(() {
                barcodeData = value!;
              });
            }, 
            enabledBorderColor: kFontTheme(context), 
            focusedBorderColor: kSecondaryColor, 
            errorBorderColor: kRedColor, 
            focusedErrorBorderColor: kRedColor, 
            errorTextStyleColor: kRedColor, 
            iconColor: kSecondaryColor, 
            cursorColor: kSecondaryColor, 
            prefixIcon: FontAwesomeIcons.barcode,
          ),

          if (widget.barcodeCategory == BarcodeCategory.ITF) NormalTextField(
            hintText: 'ITF',
            textColor: kSecondaryColor,
            textInputType: TextInputType.number,
            onChanged: (value) {
              setState(() {
                barcodeData = value!;
              });
            }, 
            enabledBorderColor: kFontTheme(context), 
            focusedBorderColor: kSecondaryColor, 
            errorBorderColor: kRedColor, 
            focusedErrorBorderColor: kRedColor, 
            errorTextStyleColor: kRedColor, 
            iconColor: kSecondaryColor, 
            cursorColor: kSecondaryColor, 
            prefixIcon: FontAwesomeIcons.barcode,
            validator: (value) {
              if (value!.length % 2 != 0) {
                return 'An even number of digits is required';
              } else if (value.isEmpty) {
                return 'This field cannot be empty';
              } else {
                return null;
              }
            },
          ),

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
        ],
      ),
    );
  }
}