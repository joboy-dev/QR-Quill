// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_quill/models/create_code.dart';
import 'package:qr_quill/models/scan_code.dart';
import 'package:qr_quill/screens/scan/qr_code/scan_qr_results.dart';
import 'package:qr_quill/services/isar_db.dart';
import 'package:qr_quill/shared/button.dart';
import 'package:qr_quill/shared/constants.dart';
import 'package:qr_quill/shared/navigator.dart';
import 'package:qr_quill/shared/snackbar.dart';
import 'package:scan/scan.dart';

class ScanQRWithCamera extends StatefulWidget {
  const ScanQRWithCamera({super.key});

  @override
  State<ScanQRWithCamera> createState() => _ScanQRWithCameraState();
}

class _ScanQRWithCameraState extends State<ScanQRWithCamera> {
  final _scanController = ScanController();
  String qrData = 'Unknown';
  bool isTorchOn = false;
  bool cameraPaused = false;
  final dateGenerated = DateTime.now().toString().substring(0, 16);


  /// Function to generate category based on qr code data 
  QRCodeCategory generateCategory() {
    if (qrData.contains('mailto:')) {
      return QRCodeCategory.Email;
    } else if (qrData.contains('WIFI:')) {
      return QRCodeCategory.Wifi;
    } else if(qrData.contains('https://') || qrData.contains('http://')) {
      return QRCodeCategory.URL;
    } else if(qrData.contains('sms:') || qrData.contains('SMSTO:')) {
      return QRCodeCategory.SMS;
    } else if(qrData.contains('BEGIN:VCARD')) {
      return QRCodeCategory.Contact;
    } else if(qrData.contains('BEGIN:VCALENDAR') || qrData.contains('BEGIN:VEVENT')) {
      return QRCodeCategory.Event;
    } else {
      return QRCodeCategory.Text;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: kAppPadding().copyWith(top: 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 0.65.sh,
                    width:  double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: kSecondaryColor,
                        width: 1.w,
                      ),
                      shape: BoxShape.rectangle,
                      // borderRadius: BorderRadius.circular(20.r),
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: ScanView(
                      controller: _scanController,
                      scanLineColor: kSecondaryColor,
                      scanAreaScale: 0.7,
                      onCapture: (data) {
                        setState(() {
                          qrData = data;
                        });
                        navigatorPushReplacement(
                          context, 
                          ScanQRResults(
                            scannedQrData: qrData, 
                            category: generateCategory().name, 
                            dateScanned: dateGenerated,
                          )
                        );

                        // add scanned code to isar db
                        IsarDB().addScannedCode(
                          context, 
                          ScanCode(
                            type: 'QR Code',
                            codeName: generateCategory().name,
                            category: generateCategory().name,
                            codeData: qrData,
                            datetime: dateGenerated
                          )
                        );
                      },
                    ),
                  ),

                  SizedBox(height: 20.h),

                  Row(
                    children: [
                      Expanded(
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              isTorchOn = !isTorchOn;
                            });
                            _scanController.toggleTorchMode();
                          }, 
                          icon: Icon(
                            isTorchOn ? Icons.flash_on_rounded : Icons.flash_off_rounded,
                            size: 30.r,
                          ),
                          color: kSecondaryColor,
                        ),
                      ),

                      Expanded(
                        child: IconButton(
                          onPressed: cameraPaused ? () {
                            setState(() {
                              cameraPaused = false;
                            });
                            _scanController.resume();
                          } : () {
                            setState(() {
                              cameraPaused = true;
                            });
                            _scanController.pause();
                          },
                          icon: Icon(
                            cameraPaused ? Icons.qr_code_scanner_rounded : Icons.pause,
                            size: 30.r,
                          ),
                          color: kSecondaryColor,
                        ),
                      ),

                      Expanded(
                        child: IconTextButton(
                          text: 'Cancel', 
                          icon: Icons.cancel, 
                          iconColor: kRedColor, 
                          fontSize: 15.sp,
                          iconsize: 30.r,
                          onPressed: () {
                            navigatorPop(context);
                            showSnackbar(context, 'Operation canceled.');
                          }
                        )
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}