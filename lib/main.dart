import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:qr_quill/screens/auth/create_pin.dart';
import 'package:qr_quill/screens/auth/verify_pin.dart';
import 'package:qr_quill/screens/splash.dart';
import 'package:qr_quill/screens/get_started.dart';
import 'package:qr_quill/services/provider/pin_storage.dart';
import 'package:qr_quill/services/provider/theme_switch.dart';
import 'package:qr_quill/shared/botttom_navbar.dart';
import 'package:qr_quill/shared/constants.dart';
import 'package:qr_quill/themes.dart';
import 'package:qr_quill/wrapper.dart';

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
          initialRoute: Splash.id,
          routes: {
            Splash.id:(context) => const Splash(),
            Wrapper.id:(context) => const Wrapper(),
            GetStarted.id:(context) => const GetStarted(),
            CreatePin.id:(context) => const CreatePin(),
            VerifyPin.id:(context) => const VerifyPin(),
            BottomNavBar.id:(context) => const BottomNavBar()
          },
          themeAnimationDuration: const Duration(milliseconds: 200),
          themeAnimationCurve: Curves.easeIn,
        );
      }
    );
  }
}
