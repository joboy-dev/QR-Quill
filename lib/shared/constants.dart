import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_quill/services/provider/theme_switch.dart';

Color kBgColorDark = const Color.fromARGB(255, 26, 25, 25);
Color kBgColorLight = const Color.fromARGB(255, 255, 247, 247);
Color kPrimaryColor = const Color.fromARGB(255, 63, 63, 63);
Color kSecondaryColor = const Color(0xffF7DC5F);
Color kTertiaryColor = const Color.fromARGB(255, 196, 196, 196);
const kRedColor = Color.fromARGB(255, 206, 15, 15);

// THEME BASED FONT COLOR
Color kFontTheme(BuildContext context) {
  final theme = context.watch<ThemeSwitch>().isDarkMode;
  return theme ? kTertiaryColor : kPrimaryColor;
}

// RESPONSIVENESS
kHeightWidth(BuildContext context) {
  return MediaQuery.of(context).size;
}

const kAppPadding = EdgeInsets.only(left: 15.0, right: 15.0, top: 20.0);

// ANIMATION DURATION
const kAnimationDuration1 = Duration(seconds: 1);
const kAnimationDuration2 = Duration(seconds: 2);
const kAnimationDuration3 = Duration(seconds: 3);
const kAnimationDuration4 = Duration(seconds: 4);
const kAnimationDuration5 = Duration(seconds: 5);

// TEXT STYLES
const kAppbarTextStyle = TextStyle(fontWeight: FontWeight.bold,);
const kNavbarTextStyle = TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold);
var kNormalTextStyle = TextStyle(fontSize: 17.0, color: kSecondaryColor);
