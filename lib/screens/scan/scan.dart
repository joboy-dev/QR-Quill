import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qr_quill/screens/scan/scan_barcode.dart';
import 'package:qr_quill/screens/scan/scan_qrcode.dart';
import 'package:qr_quill/shared/animations.dart';
import 'package:qr_quill/shared/button.dart';
import 'package:qr_quill/shared/constants.dart';
import 'package:qr_quill/shared/custom_appbar.dart';
import 'package:qr_quill/shared/navigator.dart';

class Scan extends StatefulWidget {
  const Scan({super.key});

  static const String id = 'scan';

  @override
  State<Scan> createState() => _ScanState();
}

class _ScanState extends State<Scan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: kAppPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  Expanded(
                    child: ColumnButtonIcon(
                      buttonText: 'Scan QR Code',
                      onPressed: () {
                        navigatorPush(context, const ScanQRCode());
                      },
                      buttonColor: kSecondaryColor,
                      icon: Icons.qr_code_scanner_rounded
                    ),
                  ),

                  const SizedBox(width: 20.0),

                  Expanded(
                    child: ColumnButtonIcon(
                      buttonText: 'Scan Bar Code',
                      onPressed: () {
                        navigatorPush(context, const ScanBarcode());
                      },
                      buttonColor: kSecondaryColor,
                      icon: Icons.barcode_reader,
                    ),
                  )
                ]
              )
            ),

            const SizedBox(height: 30.0),

            Expanded(
              flex: 4,
              child: Column(
                children: [
                  CustomAppbar(
                    title: 'Scan History',
                    icon: FontAwesomeIcons.clockRotateLeft,
                    titleColor: kSecondaryColor,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    elevation: 0.0,
                  ),

                  SizedBox(
                    height: kHeightWidth(context).height * 0.52,
                    child: Padding(
                      padding: kAppPadding,
                      child: ListView.builder(
                        itemCount: 50,
                        itemBuilder: (context, index) {
                          return Text(
                            'hi', 
                            style: kNormalTextStyle,
                          ).animate(
                            delay: kAnimationDurationMs(100),
                            effects: MyEffects.fadeSlide(offset: const Offset(-0.1, 0.0))
                          );
                        },
                      ),
                    ),
                  ),
                ],
              )
            )
          ].animate(
            delay: kAnimationDurationMs(1000),
            interval: kAnimationDurationMs(500),
            effects: MyEffects.fadeSlide(offset: const Offset(0.0, -0.1))
          ),
        ),
      ),
    );
  }
}