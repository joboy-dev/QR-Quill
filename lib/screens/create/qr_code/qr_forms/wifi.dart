// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qr_quill/models/create_model.dart';
import 'package:qr_quill/screens/create/qr_code/create_qr_results.dart';
import 'package:qr_quill/shared/animations.dart';
import 'package:qr_quill/shared/button.dart';
import 'package:qr_quill/shared/constants.dart';
import 'package:qr_quill/shared/logger.dart';
import 'package:qr_quill/shared/navigator.dart';
import 'package:qr_quill/shared/snackbar.dart';
import 'package:qr_quill/shared/textfield.dart';

// ignore: constant_identifier_names
enum WifiTypes {WPA, WEP, Open}

class WifiForm extends StatefulWidget {
  WifiForm({
    super.key, 
    required this.qrCodeName,
  });

  String qrCodeName;

  @override
  State<WifiForm> createState() => _WifiFormState();
}

class _WifiFormState extends State<WifiForm> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  bool obscureText = true;
  bool isLoading = false;

  WifiTypes? selectedType;

  String wifiName = '';
  String wifiPassword = '';

  String qrData = '';
  String stringData = '';

  String generateWifiUri(String wifiName, String wifiType, String wifiPassword) {
    return 'WIFI:T:$wifiType;S:$wifiName;P:$wifiPassword;;';
  }

  validateForm() async {
    if (_formKey.currentState!.validate()) {
      logger(wifiName);
      logger(wifiPassword);

      // Collect all qrData
      selectedType == WifiTypes.Open 
        ? stringData = 'Wifi Name: $wifiName\nWifi Type:: ${selectedType?.name}'
        : stringData = 'Wifi Name: $wifiName\nWifi Type:: ${selectedType?.name}\nPassword: $wifiPassword';

      showSnackbar(context, 'Generating QR Code...');
      setState(() {
        isLoading = true;
      });

      await Future.delayed(kAnimationDuration2);
      navigatorPush(context, ShowQRCode(
          qrData: generateWifiUri(wifiName, selectedType!.name, wifiPassword), 
          // qrData: stringData, 
          stringData: stringData,
          qrCodeName: widget.qrCodeName,
          selectedCategory: QRCodeCategory.Wifi,
        )
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
          NormalTextField(
            hintText: 'Wifi Name',
            textColor: kSecondaryColor,
            onChanged: (value) {
              setState(() {
                wifiName = value!;
              });
            }, 
            enabledBorderColor: kFontTheme(context), 
            focusedBorderColor: kSecondaryColor, 
            errorBorderColor: kRedColor, 
            focusedErrorBorderColor: kRedColor, 
            errorTextStyleColor: kRedColor, 
            iconColor: kSecondaryColor, 
            cursorColor: kSecondaryColor, 
            prefixIcon: Icons.wifi,
          ),

          DropDownFormField(
            value: selectedType, 
            labelText: 'Wifi Type',
            items: WifiTypes.values.map(
              (type) => DropdownMenuItem(
                value: type,
                child: Text(
                  type.name, 
                  style: kYellowNormalTextStyle(context),
                )
              ) 
            ).toList(), 
            onChanged: (value) {
              setState(() {
                selectedType = value;
              });
            }, 
            prefixIcon: Icons.wifi, 
            iconColor: kSecondaryColor, 
            enabledBorderColor: kFontTheme(context), 
            focusedBorderColor: kSecondaryColor, 
            errorBorderColor: kRedColor, 
            focusedErrorBorderColor: kRedColor, 
            errorTextStyleColor: kRedColor, 
          ),
    
          selectedType == WifiTypes.Open ? const SizedBox() : NormalTextField(
            hintText: 'Wifi Password',
            textColor: kSecondaryColor,
            textInputType: TextInputType.visiblePassword,
            onChanged: (value) {
              setState(() {
                wifiPassword = value!;
              });
            }, 
            enabledBorderColor: kFontTheme(context), 
            focusedBorderColor: kSecondaryColor, 
            errorBorderColor: kRedColor, 
            focusedErrorBorderColor: kRedColor, 
            errorTextStyleColor: kRedColor, 
            iconColor: kSecondaryColor, 
            cursorColor: kSecondaryColor, 
            obscureText: obscureText,
            prefixIcon: Icons.password,
            suffixIcon: obscureText ? FontAwesomeIcons.solidEye : FontAwesomeIcons.solidEyeSlash,
            suffixIconOTap: () {
              setState(() {
                obscureText = !obscureText;
              });
            },
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
