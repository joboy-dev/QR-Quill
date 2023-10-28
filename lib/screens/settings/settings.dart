import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:qr_quill/screens/dialog_screens/erase_data.dart';
import 'package:qr_quill/screens/settings/pin_auth.dart';
import 'package:qr_quill/services/provider/theme_switch.dart';
import 'package:qr_quill/shared/animations.dart';
import 'package:qr_quill/shared/button.dart';
import 'package:qr_quill/shared/constants.dart';
import 'package:qr_quill/shared/dialog.dart';
import 'package:qr_quill/shared/navigator.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  static const String id = 'settings';

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  @override
  Widget build(BuildContext context) {
    // read contents of the provider
    final switchTheme = context.read<ThemeSwitch>();

    // watch darkmode value in provider
    bool theme = context.watch<ThemeSwitch>().isDarkMode;
    
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: kAppPadding(),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: IconTextButton(
                        text: theme
                            ? 'Light theme'
                            : 'Dark theme',
                        icon: theme
                            ? Icons.brightness_high_rounded
                            : Icons.nightlight,
                        iconColor: kSecondaryColor,
                        
                        // textColor: theme ? kTertiaryColor: kPrimaryColor,
                        textColor: kFontTheme(context),
                        onPressed: () {},
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Transform.scale(
                        scale: 1.r,
                        child: Switch.adaptive(
                          activeColor: kSecondaryColor,
                          activeTrackColor:
                              kSecondaryColor.withOpacity(0.5),
                          inactiveThumbColor:
                              kSecondaryColor.withOpacity(0.5),
                          inactiveTrackColor: kSecondaryColor,
                          value: theme,
                          onChanged: (value) async {
                            await switchTheme.toggleThemeMode();
                            setState(() {
                              theme = value;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const SettingsDivider(),

                IconTextButton(
                  text: 'Change Pin', 
                  icon: Icons.lock, 
                  iconColor: kSecondaryColor,
                  textColor:  kFontTheme(context),
                  onPressed: () {
                    navigatorPush(context, const PinAuth());
                  },
                ),
                const SettingsDivider(),

                IconTextButton(
                  text: 'Erase all data', 
                  icon: FontAwesomeIcons.trash, 
                  iconColor: kRedColor, 
                  textColor: kRedColor,
                  fontWeight: FontWeight.normal,
                  onPressed: () {
                    showDialogBox(context: context, screen: const EraseDataDialog());
                  },
                ),
                const SettingsDivider(),

                SizedBox(
                  height: 300.h,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        image: const AssetImage('assets/images/logo.png'),
                        height: 100.h,
                        width: 100.w,
                      ),
                  
                      SizedBox(height: 10.h),
                  
                      Text(
                        'QR Quill', 
                        style: kYellowNormalTextStyle(context).copyWith(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: 10.h),
                  
                      Text(
                        'Developed by Joboy-Dev.', 
                        style: kNormalTextStyle(context).copyWith(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ].animate(
                interval: kAnimationDurationMs(200),
                effects: MyEffects.fadeSlide(offset: const Offset(-0.05, 0))
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SettingsDivider extends StatelessWidget {
  const SettingsDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 5.h),
        Divider(color: kFontTheme(context), thickness: 0.2.r),
        SizedBox(height: 10.h),
      ],
    );
  }
}