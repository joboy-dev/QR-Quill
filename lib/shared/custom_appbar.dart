import 'package:flutter/material.dart';

import 'constants.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({
    super.key, 
    required this.title,
    required this.icon,
    this.backgroundColor,
    this.titleColor,
    this.elevation,
  });

  final String title;
  final IconData icon;
  final Color? backgroundColor;
  final Color? titleColor;
  final double? elevation;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title, style: kAppbarTextStyle.copyWith(color: titleColor ?? kPrimaryColor)),
      leading: Icon(icon, color: titleColor ?? kPrimaryColor, size: 30.0),
      backgroundColor: backgroundColor ?? kSecondaryColor,
      elevation: elevation ?? 2.0,
      shadowColor: kTertiaryColor,
      scrolledUnderElevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0)
      ),
    );
  }

  // important when implementing  PreferredSizeWidget class for custom appbars
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
