// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:qr_quill/screens/dialog_screens/confirm_pin.dart';
import 'package:qr_quill/shared/botttom_navbar.dart';
import 'package:qr_quill/shared/constants.dart';
import 'package:qr_quill/shared/dialog.dart';
import 'package:qr_quill/shared/loader.dart';
import 'package:qr_quill/shared/navigator.dart';
import 'package:qr_quill/shared/textfield.dart';

class ChangePin extends StatefulWidget {
  const ChangePin({super.key});

  static const String id = 'change_pin';

  @override
  State<ChangePin> createState() => _ChangePinState();
}

class _ChangePinState extends State<ChangePin> {
  final _formKey = GlobalKey<FormState>();
  String pin = '';
  bool loading = false;

  validateForm(String pincode) async {
    if (_formKey.currentState!.validate()) {
      log(pincode);
      setState(() {
        pin = pincode;
        loading = true;
      });
      await Future.delayed(kAnimationDuration1);
      showDialogBox(
        context: context, 
        screen: ConfirmPinDialog(
          pin: pincode,
          navFunction: () {
            // navigatorPop(context);
            navigatorPushReplacementNamed(context, BottomNavBar.id);
          },
        )
      );
      setState(() {
        loading = false;
      });
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
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.6,
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
                            'Change Your Pin', 
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

