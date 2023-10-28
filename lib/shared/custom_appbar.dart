import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'constants.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({
    super.key, 
    required this.title,
    // required this.icon,
    this.backgroundColor,
    this.titleColor,
    this.elevation,
  });

  final String title;
  // final IconData icon;
  final Color? backgroundColor;
  final Color? titleColor;
  final double? elevation;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title, style: kAppbarTextStyle.copyWith(color: titleColor ?? kPrimaryColor, fontSize: 17.sp)),
      automaticallyImplyLeading: false,
      backgroundColor: backgroundColor ?? kSecondaryColor,
      elevation: elevation ?? 2.0,
      shadowColor: kFontTheme(context),
      surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
      scrolledUnderElevation: 0.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.r)
      ),
    );
  }

  // important when implementing  PreferredSizeWidget class for custom appbars
  @override
  Size get preferredSize => Size.fromHeight(40.h);
}
