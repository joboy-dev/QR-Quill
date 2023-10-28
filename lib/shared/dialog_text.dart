import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_quill/shared/constants.dart';

class DialogText extends StatelessWidget {
  const DialogText({
    super.key,
    required this.text
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    // final theme = context.watch<ThemeSwitch>().isDarkMode;

    return Column(
      children: [
        Text(
          text,
          style: kNormalTextStyle(context).copyWith(
            color: Platform.isIOS ? kPrimaryColor : kFontTheme(context),
            fontSize: 20.sp,
          ),
        ),
        SizedBox(height: 20.h),
      ],
    );
  }
}