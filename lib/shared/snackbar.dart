import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_quill/shared/animations.dart';
import 'package:qr_quill/shared/constants.dart';

showSnackbar(BuildContext context, String text, {SnackBarAction? action}) {
  ScaffoldMessenger.of(context).clearSnackBars();

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content:Text(
        text, 
        textAlign: TextAlign.center,
        style: kYellowNormalTextStyle(context).copyWith(fontSize: 17.sp)
      ).animate(effects: MyEffects.fadeSlide()),
      backgroundColor: kPrimaryColor,
      padding: EdgeInsets.symmetric(vertical: 10.r, horizontal: 20.r),
      margin: EdgeInsets.symmetric(horizontal: 20.r, vertical: 5.r),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40.r),
      ),
      duration: const Duration(seconds: 5),
      behavior: SnackBarBehavior.floating,
      dismissDirection: DismissDirection.startToEnd,
      action: action,
    ),
  );
}
