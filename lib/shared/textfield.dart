import 'package:flutter/material.dart';
import 'package:flutter_pin_code_fields/flutter_pin_code_fields.dart';
import 'package:qr_quill/shared/constants.dart';

class PinField extends StatelessWidget {
  const PinField({
    super.key,
    required this.onChange,
    required this.oncomplete,
  });

  final Function(String value) onChange;
  final Function(String pincode) oncomplete;

  @override
  Widget build(BuildContext context) {
    return PinCodeFields(
      length: 4,
      fieldHeight: 65.0,
      margin: kAppPadding,
      fieldBorderStyle: FieldBorderStyle.square,
      borderRadius: BorderRadius.circular(25.0),
      fieldBackgroundColor: Colors.transparent,
      activeBackgroundColor: Colors.transparent,
      borderColor: kTertiaryColor,
      activeBorderColor: kSecondaryColor,
      obscureText: true,
      // autofocus: true,
      keyboardType: TextInputType.number,
      textStyle: kNormalTextStyle.copyWith(
        fontSize: 42.0,
        fontWeight: FontWeight.bold,
      ),
      onComplete: oncomplete,
      onChange: onChange
    );
  }
}