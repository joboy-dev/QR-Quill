// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:qr_quill/screens/auth/verify_pin.dart';
import 'package:qr_quill/screens/dialog_screens/confirm_pin.dart';
import 'package:qr_quill/services/provider/pin_storage.dart';
import 'package:qr_quill/shared/animations.dart';
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

    savePin() async {
      showSnackbar(context, 'Setting pin...');
      await Future.delayed(kAnimationDuration1);
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
        await Future.delayed(kAnimationDuration1);

        setState(() {
          loading = false;
        });
        showDialogBox(
          context: context, 
          screen: ConfirmPinDialog(
            pin: pincode,
            navFunction: () async {
              // run function to save actual pin entered by user
              await savePin();
              // remove dialog box
              navigatorPop(context);
              // navigate to login screen
              navigatorPushReplacement(context, const VerifyPin());
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
                            Icons.lock_outline_rounded,
                            size: 200.r,
                            color: kSecondaryColor,
                          ),
            
                          SizedBox(height: 20.h),
            
                          Text(
                            'Set Your Pin', 
                            style: kNormalTextStyle.copyWith(
                              fontSize: 25.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
            
                          SizedBox(height: 20.h),
            
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
                ).animate(effects: MyEffects.fadeSlide()),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

