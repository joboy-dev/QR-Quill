// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_quill/screens/dialog_screens/reset_pin_confirmation.dart';
import 'package:qr_quill/services/provider/pin_storage.dart';
import 'package:qr_quill/shared/botttom_navbar.dart';
import 'package:qr_quill/shared/button.dart';
import 'package:qr_quill/shared/constants.dart';
import 'package:qr_quill/shared/dialog.dart';
import 'package:qr_quill/shared/loader.dart';
import 'package:qr_quill/shared/navigator.dart';
import 'package:qr_quill/shared/snackbar.dart';
import 'package:qr_quill/shared/textfield.dart';

class VerifyPin extends StatefulWidget {
  const VerifyPin({super.key});

  static const String id = 'verify_pin';

  @override
  State<VerifyPin> createState() => _VerifyPinState();
}

class _VerifyPinState extends State<VerifyPin> {
  final _formKey = GlobalKey<FormState>();
  String pin = '';
  bool loading = false;
  bool pinCorrect = false;

  @override
  Widget build(BuildContext context) {
    final pinStore = context.read<PinStorage>();

    checkPin() async {
      if (pin != pinStore.pin) {
        setState(() {
          pin = '';
        });
        showSnackbar(context, 'Pin is incorrect. Try again.');
      } else {
        setState(() {
          pinCorrect = true;
        });
        await Future.delayed(kAnimationDuration2);
        showSnackbar(context, 'Welcome.');
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

        // run function to check actual pin entered by user
        checkPin();
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
                      height: kHeightWidth(context).height * 0.8,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AnimatedContainer(
                            duration: kAnimationDuration2,
                            child: pinCorrect ? Icon(
                              Icons.lock_open_rounded,
                              size: 200.0,
                              color: kSecondaryColor,
                            ) :
                            Icon(
                              Icons.lock_outline_rounded,
                              size: 200.0,
                              color: kSecondaryColor,
                            ),
                          ),
            
                          const SizedBox(height: 20.0),
            
                          Text( 
                            'Enter your Pin', 
                            style: kNormalTextStyle.copyWith(
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 20.0),

                          ButtonText(
                            firstText: 'Can\'t remember your pin? ', 
                            secondText: 'Reset Pin', 
                            onTap: () {
                              showDialogBox(context: context, screen: const ResetPinConfirmationDialog());
                            },
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
