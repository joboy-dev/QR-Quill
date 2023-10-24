import 'package:flutter/material.dart';
import 'package:qr_quill/shared/constants.dart';

datePickerTheme(BuildContext context) => DatePickerThemeData(
  backgroundColor: kScaffoldBgColor(context),
  surfaceTintColor: kScaffoldBgColor(context),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12.0)
  ),
  dayStyle: kNormalTextStyle,
  yearStyle: kNormalTextStyle,
  weekdayStyle: kNormalTextStyle.copyWith(color: kSecondaryColor),
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
  inputDecorationTheme: const InputDecorationTheme()
);