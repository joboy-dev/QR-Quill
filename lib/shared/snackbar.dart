import 'package:flutter/material.dart';
import 'package:qr_quill/shared/constants.dart';

showSnackbar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).clearSnackBars();

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content:
          Text(text, style: kNormalTextStyle.copyWith(fontSize: 20.0, fontWeight: FontWeight.bold,)),
      backgroundColor: kPrimaryColor,
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
      margin: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 100.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40.0),
      ),
      duration: const Duration(seconds: 5),
      behavior: SnackBarBehavior.floating,
      dismissDirection: DismissDirection.startToEnd,
    ),
  );
}
