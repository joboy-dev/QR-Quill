import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_quill/shared/constants.dart';

showSnackbar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).clearSnackBars();

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content:Text(
        text, 
        textAlign: TextAlign.center,
        style: kYellowNormalTextStyle(context).copyWith(fontSize: 17.sp)
      ),
      backgroundColor: kPrimaryColor,
      padding: EdgeInsets.symmetric(vertical: 10.r, horizontal: 20.r),
      margin: EdgeInsets.symmetric(horizontal: 20.r, vertical: 5.r),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40.r),
      ),
      duration: const Duration(seconds: 5),
      behavior: SnackBarBehavior.floating,
      dismissDirection: DismissDirection.startToEnd,
    ),
  );
}
