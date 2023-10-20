import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:qr_quill/services/provider/theme_switch.dart';
import 'package:qr_quill/shared/button.dart';
import 'package:qr_quill/shared/constants.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  static const String id = 'settings';

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  @override
  Widget build(BuildContext context) {
    // final switchTheme = Provider.of<ThemeSwitch>(context);
    // bool theme = switchTheme.isDarkMode;

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
                            : FontAwesomeIcons.moon,
                        iconColor: kSecondaryColor,
                        fontSize: 22.0,
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
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}