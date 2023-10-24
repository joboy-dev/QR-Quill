import 'package:flutter/material.dart';
import 'package:qr_quill/shared/constants.dart';

showSnackbar(BuildContext context, String text) {
  clearSnackBars(context);
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content:
          Text(text, style: kNormalTextStyle.copyWith(fontSize: 20.0, fontWeight: FontWeight.bold,)),
      backgroundColor: kPrimaryColor,
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
      margin: const EdgeInsets.all(10.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      duration: const Duration(seconds: 5),
      behavior: SnackBarBehavior.floating,
      dismissDirection: DismissDirection.startToEnd,
    ),
  );
}

clearSnackBars(BuildContext context) {
  ScaffoldMessenger.of(context).clearSnackBars();
}
