// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_quill/screens/auth/login.dart';
import 'package:qr_quill/screens/dialog_screens/confirm_pin.dart';
import 'package:qr_quill/services/provider/pin_storage.dart';
import 'package:qr_quill/shared/constants.dart';
import 'package:qr_quill/shared/dialog.dart';
import 'package:qr_quill/shared/loader.dart';
import 'package:qr_quill/shared/navigator.dart';
import 'package:qr_quill/shared/snackbar.dart';
import 'package:qr_quill/shared/textfield.dart';

class CreatePin extends StatefulWidget {
  const CreatePin({super.key});

  static const String id = 'create_oin';

  @override
  State<CreatePin> createState() => _CreatePinState();
}

class _CreatePinState extends State<CreatePin> {
  final _formKey = GlobalKey<FormState>();
  String pin = '';
  bool loading = false;


  @override
  Widget build(BuildContext context) {
    final pinStore = context.read<PinStorage>();

    savePin(String pincode) {
      // check if pin is empty
      if (pincode.isEmpty) {
        setState(() {
          loading = false;
        });
        showSnackbar(context, 'Pin cannot be empty. Enter your pin.');
      }
      else {
        // save pin to flutter secure storage
        pinStore.setPin(pincode);
        showSnackbar(context, 'Pin has been set.');
      }
    }

    validateForm(String pincode) async {
      if (_formKey.currentState!.validate()) {
        log(pincode);

        setState(() {
          pin = pincode;
          loading = true;
        });

        await Future.delayed(kAnimationDuration1);

        setState(() {
          loading = false;
        });

        showDialogBox(
          context: context, 
          screen: ConfirmPinDialog(
            pin: pincode,
            navFunction: () {
              // save pin
              savePin(pin);

              // remove dialog box
              navigatorPop(context);
              // navigate to login screen
              navigatorPushReplacementNamed(context, Login.id);
            },
          )
        );
      } else {
        setState(() {
          loading = false;
        });
        showSnackbar(context, 'There was an issue with validation .Try again.');
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
                            Icons.lock_rounded,
                            size: 200.0,
                            color: kSecondaryColor,
                          ),
            
                          const SizedBox(height: 20.0),
            
                          Text(
                            'Set Your Pin', 
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

