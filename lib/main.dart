import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_quill/screens/auth/create_pin.dart';
import 'package:qr_quill/screens/auth/login.dart';
import 'package:qr_quill/screens/splash.dart';
import 'package:qr_quill/screens/get_started.dart';
import 'package:qr_quill/services/provider/pin_storage.dart';
import 'package:qr_quill/services/provider/theme_switch.dart';
import 'package:qr_quill/shared/botttom_navbar.dart';
import 'package:qr_quill/shared/constants.dart';
import 'package:qr_quill/wrapper.dart';

void main() {
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
            scaffoldBackgroundColor: kBgColorLight,
            useMaterial3: true,
          ),
          darkTheme: ThemeData(
            useMaterial3: true,
            scaffoldBackgroundColor: kBgColorDark
          ),
          themeMode: context.read<ThemeSwitch>().isDarkMode ? ThemeMode.dark : ThemeMode.light,
          debugShowCheckedModeBanner: false,
          initialRoute: Splash.id,
          routes: {
            Splash.id:(context) => const Splash(),
            Wrapper.id:(context) => const Wrapper(),
            GetStarted.id:(context) => const GetStarted(),
            CreatePin.id:(context) => const CreatePin(),
            Login.id:(context) => const Login(),
            BottomNavBar.id:(context) => const BottomNavBar()
          },
        );
      }
    );
  }
}
