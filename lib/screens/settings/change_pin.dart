// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

    savePin() async {
      // check if pin is empty
      if (pin.isEmpty) {
        setState(() {
          loading = false;
        });
        showSnackbar(context, 'Pin cannot be empty. Enter your pin.');
      }
      else {
        showSnackbar(context, 'Changing pin...');
        await Future.delayed(kAnimationDuration1);

        // check if pin is the same as the previous one
        if (pin == pinStore.pin) {
          showSnackbar(context, 'New pin cannot be the same as the old one');
        } else { 
          // save pin to flutter secure storage
          pinStore.setPin(pin);
          showSnackbar(context, 'Pin has been set to $pin.');
          navigatorPop(context);
        }
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
      } else {
        
      }
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: kAppPadding(),
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
                            size: 200.r,
                            color: kSecondaryColor,
                          ),
            
                          SizedBox(height: 20.h),
            
                          Text(
                            'Change Your Pin', 
                            style: kYellowNormalTextStyle(context).copyWith(
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
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

