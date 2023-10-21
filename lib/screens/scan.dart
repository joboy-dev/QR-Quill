import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qr_quill/screens/scan_barcode.dart';
import 'package:qr_quill/screens/scan_qrcode.dart';
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
                        navigatorPushNamed(context, ScanQRCode.id);
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
                        navigatorPushNamed(context, ScanBarcode.id);
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
              flex: 2,
              child: Column(
                children: [
                  CustomAppbar(
                    title: 'Scan History',
                    icon: FontAwesomeIcons.clockRotateLeft,
                    titleColor: kSecondaryColor,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    elevation: 0.0,
                  )
                ],
              )
            )
          ],
        ),
      ),
    );
  }
}