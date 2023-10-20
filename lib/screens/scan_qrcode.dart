import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qr_quill/shared/button.dart';
import 'package:qr_quill/shared/constants.dart';
import 'package:qr_quill/shared/custom_appbar.dart';

class ScanQRCode extends StatefulWidget {
  const ScanQRCode({super.key});

  static const String id = 'scan';

  @override
  State<ScanQRCode> createState() => _ScanQRCodeState();
}

class _ScanQRCodeState extends State<ScanQRCode> {
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
                      onPressed: () {},
                      buttonColor: kSecondaryColor,
                      icon: Icons.qr_code_scanner_rounded
                    ),
                  ),

                  const SizedBox(width: 20.0),

                  Expanded(
                    child: ColumnButtonIcon(
                      buttonText: 'Scan Bar Code',
                      onPressed: () {},
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