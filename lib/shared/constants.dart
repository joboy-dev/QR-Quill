import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:qr_quill/services/provider/theme_switch.dart';

Color kBgColorDark = const Color.fromARGB(255, 26, 25, 25);
Color kBgColorLight = const Color.fromARGB(255, 255, 247, 247);
Color kPrimaryColor = const Color.fromARGB(255, 63, 63, 63);
// Color kSecondaryColor = const Color(0xffF7DC5F);
Color kSecondaryColor = const Color.fromARGB(255, 192, 170, 73);
// Color kSecondaryColor = Color.fromARGB(255, 132, 114, 214);
Color kTertiaryColor = const Color.fromARGB(255, 196, 196, 196);
const kRedColor = Color.fromARGB(255, 206, 15, 15);
Color kScaffoldBgColor(BuildContext context) => Theme.of(context).scaffoldBackgroundColor;

// THEME BASED FONT COLOR
Color kFontTheme(BuildContext context) {
  final darkMode = context.watch<ThemeSwitch>().isDarkMode;
  return darkMode ? kTertiaryColor : kPrimaryColor;
}

// RESPONSIVENESS
Size kHeightWidth(BuildContext context) {
  return MediaQuery.of(context).size;
}

EdgeInsets kAppPadding() => EdgeInsets.only(left: 10.r, right: 10.r, top: 15.r);

// ANIMATION DURATION
Duration kAnimationDurationMs(int ms) => Duration(milliseconds: ms);
Duration kAnimationDurationSecs(int seconds) => Duration(seconds: seconds);
const kAnimationDuration1 = Duration(seconds: 1);
const kAnimationDuration2 = Duration(seconds: 2);
const kAnimationDuration3 = Duration(seconds: 3);
const kAnimationDuration4 = Duration(seconds: 4);
const kAnimationDuration5 = Duration(seconds: 5);

// TEXT STYLES
const kAppbarTextStyle = TextStyle(fontWeight: FontWeight.bold);
TextStyle kNavbarTextStyle() => TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold);

TextStyle kTextFieldTextStyle() => TextStyle(fontSize: 15.sp, color: kSecondaryColor);
TextStyle kNormalTextStyle(BuildContext context) => TextStyle(fontSize: 15.sp, color: kFontTheme(context));
TextStyle kYellowNormalTextStyle(BuildContext context) => TextStyle(fontSize: 15.sp, color: kSecondaryColor);
