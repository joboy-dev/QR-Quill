import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:qr_quill/screens/splash.dart';
import 'package:qr_quill/services/provider/pin_storage.dart';
import 'package:qr_quill/services/provider/theme_switch.dart';
import 'package:qr_quill/shared/constants.dart';
import 'package:qr_quill/themes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeSwitch()),
        ChangeNotifierProvider(create: (_) => PinStorage()),
      ],
      child: const QRQuill(),
    ),
  );
}

class QRQuill extends StatelessWidget {
  const QRQuill({super.key});

  @override
  Widget build(BuildContext context) {
    Animate.restartOnHotReload = true;
    
    return Consumer<ThemeSwitch>(
      builder: (context, theme, child) {
        return MaterialApp(
          title: 'QR Quill',
          theme: ThemeData(
            useMaterial3: true,
            scaffoldBackgroundColor: kBgColorLight,
            splashColor: kSecondaryColor.withOpacity(0.5),
            datePickerTheme: datePickerTheme(context),
          ),
          darkTheme: ThemeData(
            useMaterial3: true,
            scaffoldBackgroundColor: kBgColorDark,
            splashColor: kSecondaryColor.withOpacity(0.5),
            datePickerTheme: datePickerTheme(context),
          ),
          themeMode: context.read<ThemeSwitch>().isDarkMode ? ThemeMode.dark : ThemeMode.light,
          debugShowCheckedModeBanner: false,
          home: const Splash(),
          themeAnimationDuration: const Duration(milliseconds: 200),
          themeAnimationCurve: Curves.easeIn,
        );
      }
    );
  }
}
