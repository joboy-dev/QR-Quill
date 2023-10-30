// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_quill/models/create_model.dart';
import 'package:qr_quill/screens/scan/qr_code/scan_qr_from_image.dart';
import 'package:qr_quill/screens/scan/qr_code/scan_qr_with_camera.dart';
import 'package:qr_quill/screens/scan/qr_code/scan_qr_results.dart';
import 'package:qr_quill/shared/button.dart';
import 'package:qr_quill/shared/constants.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:qr_quill/shared/logger.dart';
import 'package:qr_quill/shared/navigator.dart';
import 'package:qr_quill/shared/snackbar.dart';
import 'package:scan/scan.dart';

class ScanQRCode extends StatefulWidget {
  const ScanQRCode({super.key});

  static const String id = 'scan_qrrcode';

  @override
  State<ScanQRCode> createState() => _ScanQRCodeState();
}

class _ScanQRCodeState extends State<ScanQRCode> {
  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  String _platformVersion = 'Unknown';
  
  Future<void> initPlatformState() async {
    String platformVersion;
    try {
      platformVersion = await Scan.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  /// Function to generate category based on qr code data 
  // Category generateCategory() {
  //   if (scanQRCode.contains('mailto:')) {
  //     return Category.Email;
  //   } else if (scanQRCode.contains('WIFI:')) {
  //     return Category.Wifi;
  //   } else if(scanQRCode.contains('https://') || scanQRCode.contains('http://')) {
  //     return Category.URL;
  //   } else if(scanQRCode.contains('sms:')) {
  //     return Category.SMS;
  //   } else if(scanQRCode.contains('BEGIN:VCARD')) {
  //     return Category.Contact;
  //   } else if(scanQRCode.contains('BEGIN:VCALENDAR') || scanQRCode.contains('BEGIN:VEVENT')) {
  //     return Category.Event;
  //   } else {
  //     return Category.Text;
  //   }
  // }

  // String scanQRCode = 'none';

  // Future<void> scanQRWithCamera() async {
  //   String qrScanResult;

  //   // Platform messages may fail, so we use a try/catch PlatformException.
  //   try {
  //     qrScanResult = await FlutterBarcodeScanner.scanBarcode(
  //       '#F7DC5F', 
  //       'Cancel', 
  //       true, 
  //       ScanMode.QR
  //     );
  //     logger('QR Scan Result: $scanQRCode');

  //     // check if user scans the qr code completely
  //     if (qrScanResult != '-1') {
  //       setState(() {
  //         scanQRCode = qrScanResult;
  //       });
  //       showSnackbar(context, 'QR Code scan successful.');
  //       navigatorPush(context, ScanQRResults(scannedQrData: qrScanResult, category: generateCategory()));
  //     } else {
  //       showSnackbar(context, 'Operation canceled.');
  //     }
  //   } on PlatformException {
  //     logger('Could not get platform version');
  //   }
  //   // In case widget was removed from widget tree while scanning is going on
  //   if (!mounted) return;
  // }

  // scanQRWithImage() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: kAppPadding(),
              child: Column(
                children: [
                  Button(
                    buttonText: 'Scan with Camera', 
                    // onPressed: scanQRWithCamera,
                    onPressed: () {
                      navigatorPush(context, const ScanQRWithCamera());
                    },
                    buttonColor: kSecondaryColor, 
                    inactive: false,
                  ),
            
                  SizedBox(height: 20.h),
            
                  Button(
                    buttonText: 'Scan Image', 
                    onPressed: () {
                      navigatorPush(context, const ScanQRFromImage());
                    }, 
                    buttonColor: kTertiaryColor, 
                    inactive: false,
                  ),
            
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}