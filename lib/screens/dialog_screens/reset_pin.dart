import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_quill/services/provider/pin_storage.dart';
import 'package:qr_quill/shared/button.dart';
import 'package:qr_quill/shared/constants.dart';
import 'package:qr_quill/shared/dialog_header.dart';
import 'package:qr_quill/shared/dialog_text.dart';
import 'package:qr_quill/shared/navigator.dart';
import 'package:qr_quill/shared/snackbar.dart';

class ResetPinDialog extends StatefulWidget {
  const ResetPinDialog({super.key});

  @override
  State<ResetPinDialog> createState() => _ResetPinDialogState();
}

class _ResetPinDialogState extends State<ResetPinDialog> {
  // Generate random pin
  int pincode = Random().nextInt(9000) + 1000;
  String _pin = '';

  @override
  Widget build(BuildContext context) {
    final pinStore = context.read<PinStorage>();

    savePin () {
      setState(() {
        // convert random pin number to string
      _pin = pincode.toString();
      });

      // save pin to flutter secure storage
      pinStore.setPin(_pin);
      showSnackbar(context, 'Pin has been set to $_pin.');
      navigatorPop(context);
    }

    return Column(
      children: [
        const DialogHeader(
          headerText: 'Reset Pin', 
          mainColor: kRedColor,
          icon: Icons.restore,
        ),

        DialogText(
          text: 'Your new pin is $pincode.',
        ),

        DoubleButton(
          inactiveButton: false, 
          button2Text: 'Proceed', 
          button2Color: kSecondaryColor, 
          button2onPressed: () {
            savePin();
          }
        )
      ],
    );
  }
}
