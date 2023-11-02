// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_quill/models/create_code.dart';
import 'package:qr_quill/models/scan_code.dart';
import 'package:qr_quill/screens/scan/barcode/scan_barcode_results.dart';
import 'package:qr_quill/services/isar_db.dart';
import 'package:qr_quill/shared/button.dart';
import 'package:qr_quill/shared/constants.dart';
import 'package:qr_quill/shared/navigator.dart';
import 'package:qr_quill/shared/snackbar.dart';
import 'package:scan/scan.dart';

class ScanBarcodeWithCamera extends StatefulWidget {
  const ScanBarcodeWithCamera({super.key});

  @override
  State<ScanBarcodeWithCamera> createState() => _ScanBarcodeWithCameraState();
}

class _ScanBarcodeWithCameraState extends State<ScanBarcodeWithCamera> {
  final _scanController = ScanController();
  String barcodeData = 'Unknown';
  bool isTorchOn = false;
  bool cameraPaused = false;
  final dateGenerated = DateTime.now().toString().substring(0, 16);

  /// Function to generate category based on qr code data 
  BarcodeCategory generateCategory(String data) {
    if(RegExp(r'^(978|979)\d{10}$').hasMatch(data)) {
      return BarcodeCategory.ISBN;
    } else if (RegExp(r'^[A-Z0-9]+$').hasMatch(data)) {
      return BarcodeCategory.DataMatrix;
    } else if(RegExp(r'^[A-Za-z0-9]+$').hasMatch(data)) {
      return BarcodeCategory.Aztec;
    } else if(RegExp(r'^[0-9]{13}$').hasMatch(data)) {
      return BarcodeCategory.EAN13;
    } else if(RegExp(r'^[0-9]{8}$').hasMatch(data)) {
      return BarcodeCategory.EAN8;
    } else if(RegExp(r'^[0-9]{5}$').hasMatch(data)) {
      return BarcodeCategory.EAN5;
    } else if(RegExp(r'^[0-9]{13}$').hasMatch(data)) {
      return BarcodeCategory.EAN2;
    } else if(RegExp(r'^[0-9]{8}$').hasMatch(data)) {
      return BarcodeCategory.UPC_E;
    } else if(RegExp(r'^[0-9]{12}$').hasMatch(data)) {
      return BarcodeCategory.UPC_A;
    } else if(RegExp(r'^[A-Z0-9]+$').hasMatch(data)) {
      return BarcodeCategory.Code128;
    } else if(RegExp(r'^[A-Z0-9]+$').hasMatch(data)) {
      return BarcodeCategory.Code93;
    } else if(RegExp(r'^[A-Z0-9]+$').hasMatch(data)) {
      return BarcodeCategory.Code39;
    } else if(RegExp(r'^[A-D0-9$/.+\-:]+$').hasMatch(data)) {
      return BarcodeCategory.Codabar;
    } else if(RegExp(r'^[0-9]$').hasMatch(data) && data.length % 2 == 0) {
      return BarcodeCategory.ITF;
    } else {
      return BarcodeCategory.PDF417;
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
                          barcodeData = data;
                        });
                        navigatorPushReplacement(
                          context, 
                          ScanBarcodeResults(
                            scannedBarcodeData: barcodeData, 
                            category: generateCategory(barcodeData).name, 
                            dateScanned: dateGenerated,
                          )
                        );

                        // add scanned code to isar db
                        IsarDB().addScannedCode(
                          context, 
                          ScanCode(
                            type: 'Barcode',
                            codeName: generateCategory(barcodeData).name,
                            category: generateCategory(barcodeData).name,
                            codeData: barcodeData,
                            datetime: dateGenerated,
                          ),
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
                            cameraPaused ? Icons.barcode_reader : Icons.pause,
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