import 'package:flutter/material.dart';
import 'package:qr_quill/shared/constants.dart';
import 'package:flutter_animate/flutter_animate.dart';

showDialogBox(
    {required BuildContext context,
    required Widget screen,
    bool dismisible = true}) {
  final GlobalKey<FormState> dialogKey = GlobalKey<FormState>();
  showDialog(
    context: context,
    barrierDismissible: dismisible,
    builder: (context) {
      return AlertDialog.adaptive(
        key: dialogKey,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        surfaceTintColor: kFontTheme(context),
        elevation: 4.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        scrollable: true,
        content: screen.animate().fadeIn(duration: kAnimationDurationMs(200)),
      );
    },
  );
}
