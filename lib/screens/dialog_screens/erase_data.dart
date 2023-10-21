import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qr_quill/screens/get_started.dart';
import 'package:qr_quill/shared/button.dart';
import 'package:qr_quill/shared/constants.dart';
import 'package:qr_quill/shared/dialog_header.dart';
import 'package:qr_quill/shared/navigator.dart';
import 'package:qr_quill/wrapper.dart';

import '../../shared/dialog_text.dart';

class EraseDataDialog extends StatefulWidget {
  const EraseDataDialog({super.key});

  @override
  State<EraseDataDialog> createState() => _EraseDataDialogState();
}

class _EraseDataDialogState extends State<EraseDataDialog> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const DialogHeader(
          headerText: 'Erase Data', 
          mainColor: kRedColor,
          icon: FontAwesomeIcons.trash,
        ),

        const DialogText(
          text: 'This is an irreversible process. Are you sure you want to do this?',
        ),

        DoubleButton(
          inactiveButton: false, 
          button2Text: 'Yes', 
          button2Color: kSecondaryColor, 
          button2onPressed: () {
            navigatorPushReplacementNamed(context, GetStarted.id);
            // navigatorPushReplacementNamed(context, Wrapper.id);
          }
        )
      ],
    );
  }
}
