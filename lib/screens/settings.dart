import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:qr_quill/screens/change_pin.dart';
import 'package:qr_quill/screens/dialog_screens/erase_data.dart';
import 'package:qr_quill/services/provider/theme_switch.dart';
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
            padding: kAppPadding,
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
                  ],
                ),
                const SettingsDivider(),

                IconTextButton(
                  text: 'Change Pin', 
                  icon: Icons.lock, 
                  iconColor: kSecondaryColor,
                  // textColor:  theme ? kTertiaryColor: kPrimaryColor,
                  textColor:  kFontTheme(context),
                  onPressed: () {
                    navigatorPushNamed(context, ChangePin.id);
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
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Image(
                        image: AssetImage('assets/images/logo.png'),
                        height: 100,
                        width: 100,
                      ),
                  
                      const SizedBox(height: 10.0),
                  
                      Text(
                        'QR Quill', 
                        style: kNormalTextStyle.copyWith(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 10.0),
                  
                      Text(
                        'Developed by Joboy-Dev.', 
                        style: kNormalTextStyle.copyWith(
                          color: kFontTheme(context),
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
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
        const SizedBox(height: 5.0),
        Divider(color: kTertiaryColor),
        const SizedBox(height: 10.0),
      ],
    );
  }
}