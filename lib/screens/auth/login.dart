import 'package:flutter/material.dart';
import 'package:qr_quill/shared/botttom_navbar.dart';
import 'package:qr_quill/shared/button.dart';
import 'package:qr_quill/shared/constants.dart';
import 'package:qr_quill/shared/navigator.dart';

import 'package:flutter_pin_code_fields/flutter_pin_code_fields.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  static const String id = 'login';

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: kAppPadding,
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.lock_rounded,
                          size: 200.0,
                          color: kSecondaryColor,
                        ),

                        const SizedBox(height: 20.0),

                        Text(
                          'Enter Pin', 
                          style: kNormalTextStyle.copyWith(
                            fontSize: 35.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 20.0),

                        PinCodeFields(
                          length: 4,
                          fieldHeight: 65.0,
                          margin: kAppPadding,
                          fieldBorderStyle: FieldBorderStyle.square,
                          borderRadius: BorderRadius.circular(25.0),
                          fieldBackgroundColor: Colors.transparent,
                          activeBackgroundColor: Colors.transparent,
                          borderColor: kTertiaryColor,
                          activeBorderColor: kSecondaryColor,
                          // autofocus: true,
                          keyboardType: TextInputType.number,
                          textStyle: kNormalTextStyle.copyWith(
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                          ),
                          onComplete: (pin) {}
                        )
                      ],
                    ),
                  ),

                  Button(
                    buttonText: 'Login',
                    onPressed: () {
                      navigatorPushReplacementNamed(context, BottomNavBar.id);
                    }, 
                    buttonColor: kSecondaryColor, 
                    inactive: false,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}