import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qr_quill/shared/animations.dart';
import 'package:qr_quill/shared/button.dart';
import 'package:qr_quill/shared/constants.dart';
import 'package:qr_quill/shared/dialog_header.dart';
import 'package:qr_quill/shared/dialog_text.dart';

class DeleteDialog extends StatefulWidget {
  const DeleteDialog({super.key, required this.deleteFunction, required this.indexId});
  
  final Function() deleteFunction;
  final int indexId;

  @override
  State<DeleteDialog> createState() => _DeleteDialogState();
}

class _DeleteDialogState extends State<DeleteDialog> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const DialogHeader(
          headerText: 'Delete', 
          mainColor: kRedColor,
          icon: FontAwesomeIcons.trash,
        ),

        const DialogText(
          text: 'Are you sure?',
        ),

        DoubleButton(
          inactiveButton: false, 
          button2Text: 'Yes', 
          button2Color: kSecondaryColor, 
          button2onPressed: widget.deleteFunction,
        )
      ].animate(
        interval: kAnimationDurationMs(200),
        effects: MyEffects.fadeSlide(),
      ),
    );
  }
}
