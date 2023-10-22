import 'package:flutter/material.dart';
import 'package:qr_quill/screens/auth/login.dart';
import 'package:qr_quill/shared/button.dart';
import 'package:qr_quill/shared/constants.dart';
import 'package:qr_quill/shared/dialog_header.dart';
import 'package:qr_quill/shared/dialog_text.dart';
import 'package:qr_quill/shared/navigator.dart';

class ConfirmPinDialog extends StatefulWidget {
  const ConfirmPinDialog({super.key, required this.pin, required this.navFunction});

  final String pin;
  final Function() navFunction;

  @override
  State<ConfirmPinDialog> createState() => _ConfirmPinDialogState();
}

class _ConfirmPinDialogState extends State<ConfirmPinDialog> {
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DialogHeader(
          headerText: 'Confirm Pin', 
          mainColor: kSecondaryColor,
          icon: Icons.lock_rounded,
        ),

        DialogText(
          text: '${widget.pin} will be your pin. Are you sure?',
        ),

        DoubleButton(
          inactiveButton: false, 
          button2Text: 'Yes', 
          button2Color: kSecondaryColor, 
          button2onPressed: widget.navFunction,
        )
      ],
    );
  }
}
