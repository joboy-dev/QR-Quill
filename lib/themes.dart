import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_quill/shared/constants.dart';

datePickerTheme(BuildContext context) => DatePickerThemeData(
  backgroundColor: kScaffoldBgColor(context),
  surfaceTintColor: kScaffoldBgColor(context),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(40.r)
  ),
  dayStyle: kNormalTextStyle(context),
  yearStyle: kNormalTextStyle(context),
  weekdayStyle: kYellowNormalTextStyle(context),
  dayBackgroundColor: MaterialStatePropertyAll(kScaffoldBgColor(context)),
  dayForegroundColor: MaterialStatePropertyAll(kFontTheme(context)),
  dayOverlayColor: MaterialStatePropertyAll(kSecondaryColor),
  yearBackgroundColor: MaterialStatePropertyAll(kScaffoldBgColor(context)),
  yearForegroundColor: MaterialStatePropertyAll(kFontTheme(context)),
  yearOverlayColor: MaterialStatePropertyAll(kSecondaryColor),
  todayForegroundColor: MaterialStatePropertyAll(kSecondaryColor),
  todayBackgroundColor: MaterialStatePropertyAll(kScaffoldBgColor(context)),
  todayBorder: BorderSide(color: kSecondaryColor),
  headerForegroundColor: kScaffoldBgColor(context),
  headerBackgroundColor: kSecondaryColor,
  rangeSelectionBackgroundColor: kSecondaryColor,
  rangeSelectionOverlayColor: MaterialStatePropertyAll(kSecondaryColor),
  inputDecorationTheme: InputDecorationTheme(
    labelStyle: kYellowNormalTextStyle(context),
    hintStyle: kNormalTextStyle(context),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: kSecondaryColor, width: 1.w),
      borderRadius: BorderRadius.all(Radius.circular(20.r)),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: kSecondaryColor, width: 1.w),
      borderRadius: BorderRadius.all(Radius.circular(20.r)),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: kRedColor, width: 1.w),
      borderRadius: BorderRadius.all(Radius.circular(20.r)),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: kRedColor, width: 1.w),
      borderRadius: BorderRadius.all(Radius.circular(20.r)),
    ),
    errorStyle: TextStyle(
      color: kRedColor,
      fontSize: 15.sp,
    ),
  ),
);

timePickerTheme(BuildContext context) => TimePickerThemeData(
  backgroundColor: kScaffoldBgColor(context),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(40.r)
  ),
  dialBackgroundColor: kScaffoldBgColor(context),
  dialHandColor: kSecondaryColor,
  dialTextStyle: kNormalTextStyle(context), 
  hourMinuteColor: kSecondaryColor,
  hourMinuteTextColor: kPrimaryColor,
  hourMinuteTextStyle: kNormalTextStyle(context).copyWith(
    fontSize: 40.sp,
    fontWeight: FontWeight.bold
  ),
  inputDecorationTheme: InputDecorationTheme(
    labelStyle: kYellowNormalTextStyle(context),
    hintStyle: kNormalTextStyle(context),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: kSecondaryColor, width: 1.w),
      borderRadius: BorderRadius.all(Radius.circular(20.r)),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: kSecondaryColor, width: 1.w),
      borderRadius: BorderRadius.all(Radius.circular(20.r)),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: kRedColor, width: 1.w),
      borderRadius: BorderRadius.all(Radius.circular(20.r)),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: kRedColor, width: 1.w),
      borderRadius: BorderRadius.all(Radius.circular(20.r)),
    ),
    errorStyle: TextStyle(
      color: kRedColor,
      fontSize: 15.sp,
    ),
  ),

);