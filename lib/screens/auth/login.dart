// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_quill/screens/dialog_screens/confirm_pin.dart';
import 'package:qr_quill/services/provider/pin_storage.dart';
import 'package:qr_quill/shared/botttom_navbar.dart';
import 'package:qr_quill/shared/constants.dart';
import 'package:qr_quill/shared/dialog.dart';
import 'package:qr_quill/shared/loader.dart';
import 'package:qr_quill/shared/navigator.dart';
import 'package:qr_quill/shared/snackbar.dart';
import 'package:qr_quill/shared/textfield.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  static const String id = 'login';

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  String pin = '';
  bool loading = false;
  bool pinCorrect = false;

  @override
  Widget build(BuildContext context) {
    final pinStore = context.read<PinStorage>();

    checkPin(String pincode) async {
      if (pincode != pinStore.pin) {
        showSnackbar(context, 'Pin is incorrect. Try again.');
      } else {
        setState(() {
          pinCorrect = true;
        });
        await Future.delayed(kAnimationDuration2);
        showSnackbar(context, 'Pin is correct. Welcome.');
        navigatorPushReplacementNamed(context, BottomNavBar.id);
      }
    }

    validateForm(String pincode) async {
      if (_formKey.currentState!.validate()) {
        log(pincode);
        setState(() {
          pin = pincode;
          loading = true;
        });

        await Future.delayed(kAnimationDuration2);
        setState(() {
          loading = false;
        });

        checkPin(pin);
      } else {
        
      }
    }
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: kAppPadding,
            child: Form(
              key: _formKey,
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.8,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            pinCorrect ? Icons.lock_open_rounded : Icons.lock_rounded, // change icon if pin entered is correct
                            size: 200.0,
                            color: kSecondaryColor,
                          ),
            
                          const SizedBox(height: 20.0),
            
                          Text( 
                            'Enter Your Pin', 
                            style: kNormalTextStyle.copyWith(
                              fontSize: 35.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
            
                          const SizedBox(height: 20.0),
            
                          PinField(
                            onChange: (value) {
                              setState(() {
                                pin = value;
                              });
                            },
                            oncomplete: (pincode) {
                              validateForm(pincode);
                            },
                          )
                        ],
                      ),
                    ),

                    loading ? const Loader() : const SizedBox(),
            
                    // Button(
                    //   buttonText: 'Set Pin',
                    //   onPressed: () {
                    //     showDialogBox(context: context, screen: ConfirmPinDialog(pin: pin));
                    //   }, 
                    //   buttonColor: kSecondaryColor, 
                    //   inactive: false,
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

