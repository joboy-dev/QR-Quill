import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:qr_quill/screens/dialog_screens/reset_pin.dart';
import 'package:qr_quill/shared/animations.dart';
import 'package:qr_quill/shared/button.dart';
import 'package:qr_quill/shared/constants.dart';
import 'package:qr_quill/shared/dialog.dart';
import 'package:qr_quill/shared/dialog_header.dart';
import 'package:qr_quill/shared/dialog_text.dart';
import 'package:qr_quill/shared/navigator.dart';

class ResetPinConfirmationDialog extends StatefulWidget {
  const ResetPinConfirmationDialog({super.key});

  @override
  State<ResetPinConfirmationDialog> createState() => _ResetPinConfirmationDialogState();
}

class _ResetPinConfirmationDialogState extends State<ResetPinConfirmationDialog> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const DialogHeader(
          headerText: 'Confirm Reset', 
          mainColor: kRedColor,
          icon: Icons.restore,
        ),

        const DialogText(
          text: 'This action will reset your pin and give you a random pin. Don\'t worry, you can always change the pin from Settings.',
        ),

        DoubleButton(
          inactiveButton: false, 
          button2Text: 'Proceed', 
          button2Color: kSecondaryColor, 
          button2onPressed: () {
            navigatorPop(context);
            showDialogBox(context: context, screen: const ResetPinDialog());
          }
        )
      ].animate(
        interval: kAnimationDurationMs(200),
        effects: MyEffects.fadeSlide(),
      ),
    );
  }
}
