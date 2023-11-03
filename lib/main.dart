import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:qr_quill/screens/splash.dart';
import 'package:qr_quill/services/provider/create_code_provider.dart';
import 'package:qr_quill/services/provider/pin_storage.dart';
import 'package:qr_quill/services/provider/scan_code_provider.dart';
import 'package:qr_quill/services/provider/theme_switch.dart';
import 'package:qr_quill/shared/constants.dart';
import 'package:qr_quill/themes.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeSwitch()),
        ChangeNotifierProvider(create: (_) => PinStorage()),
        ChangeNotifierProvider(create: (_) => CreateCodeProvider()),
        ChangeNotifierProvider(create: (_) => ScanCodeProvider()),
      ],
      // child: DevicePreview(
      //   enabled: !kReleaseMode,
      //   builder: (context) => const QRQuill(),
      // ),
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
        return ScreenUtilInit(
          designSize: const Size(360, 690),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (_, child) => MaterialApp(
            title: 'QR Quill',
            locale: DevicePreview.locale(context),
            builder: DevicePreview.appBuilder,
            theme: ThemeData(
              useMaterial3: true,
              scaffoldBackgroundColor: kBgColorLight,
              splashColor: kSecondaryColor.withOpacity(0.5),
              datePickerTheme: datePickerTheme(context),
              timePickerTheme: timePickerTheme(context),
            ),
            darkTheme: ThemeData(
              useMaterial3: true,
              scaffoldBackgroundColor: kBgColorDark,
              splashColor: kSecondaryColor.withOpacity(0.5),
              datePickerTheme: datePickerTheme(context),
              timePickerTheme: timePickerTheme(context),
            ),
            themeMode: context.read<ThemeSwitch>().isDarkMode ? ThemeMode.dark : ThemeMode.light,
            debugShowCheckedModeBanner: false,
            home: const Splash(),
            themeAnimationDuration: const Duration(milliseconds: 200),
            themeAnimationCurve: Curves.easeIn,
          ),
        );
      }
    );
  }
}
