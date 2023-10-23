// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_quill/services/provider/pin_storage.dart';
import 'package:qr_quill/shared/constants.dart';
import 'package:qr_quill/shared/loader.dart';
import 'package:qr_quill/shared/navigator.dart';
import 'package:qr_quill/shared/snackbar.dart';
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


  @override
  Widget build(BuildContext context) {
    final pinStore = context.read<PinStorage>();

    savePin() {
      // check if pin is empty
      if (pin.isEmpty) {
        setState(() {
          loading = false;
        });
        showSnackbar(context, 'Pin cannot be empty. Enter your pin.');
      }
      else {
        // save pin to flutter secure storage
        pinStore.setPin(pin);
        showSnackbar(context, 'Pin has been set to $pin.');
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
        savePin();
        navigatorPop(context);
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
                      height: kHeightWidth(context).height * 0.6,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.lock_outline_rounded,
                            size: 200.0,
                            color: kSecondaryColor,
                          ),
            
                          const SizedBox(height: 20.0),
            
                          Text(
                            'Change Your Pin', 
                            style: kNormalTextStyle.copyWith(
                              fontSize: 25.0,
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

