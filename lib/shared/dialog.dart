import 'package:flutter/material.dart';
import 'package:qr_quill/shared/constants.dart';

showDialogBox(
    {required BuildContext context,
    required Widget screen,
    bool dismisible = true}) {
  showDialog(
    context: context,
    barrierDismissible: dismisible,
    builder: (context) {
      return AlertDialog.adaptive(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        surfaceTintColor: kPrimaryColor,
        elevation: 4.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        scrollable: true,
        content: screen,
      );
    },
  );
}
