// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_quill/models/create_code.dart';
import 'package:qr_quill/services/qr_barcode_utility_functions.dart';
import 'package:qr_quill/shared/button.dart';
import 'package:qr_quill/shared/constants.dart';
import 'package:qr_quill/shared/custom_appbar.dart';
import 'package:qr_quill/shared/snackbar.dart';
import 'package:share_plus/share_plus.dart';

class ScanBarcodeResults extends StatefulWidget {
  const ScanBarcodeResults({
    super.key, 
    required this.scannedBarcodeData, 
    required this.category, 
    this.imagePath,
    required this.dateScanned,
  });

  final String scannedBarcodeData;
  final String? imagePath;
  final String category;
  final String dateScanned;

  @override
  State<ScanBarcodeResults> createState() => _ScanBarcodeResultsState();
}

class _ScanBarcodeResultsState extends State<ScanBarcodeResults> {
  final _barcodeImageKey = GlobalKey();

  Barcode? generateBarcode() {
    if (widget.category == BarcodeCategory.Aztec.name) {
      return Barcode.aztec();
    } else if (widget.category == BarcodeCategory.Codabar.name) {
      return Barcode.codabar();
    } else if (widget.category == BarcodeCategory.Code128.name) {
      return Barcode.code128();
    } else if (widget.category == BarcodeCategory.Code39.name) {
      return Barcode.code39();
    } else if (widget.category == BarcodeCategory.Code93.name) {
      return Barcode.code93();
    } else if (widget.category == BarcodeCategory.DataMatrix.name) {
      return Barcode.dataMatrix();
    } else if (widget.category == BarcodeCategory.EAN13.name) {
      return Barcode.ean13();
    } else if (widget.category == BarcodeCategory.EAN8.name) {
      return Barcode.ean8();
    } else if (widget.category == BarcodeCategory.EAN5.name) {
      return Barcode.ean5();
    } else if (widget.category == BarcodeCategory.EAN2.name) {
      return Barcode.ean2();
    } else if (widget.category == BarcodeCategory.ISBN.name) {
      return Barcode.isbn();
    } else if (widget.category == BarcodeCategory.ITF.name) {
      return Barcode.itf();
    } else if (widget.category == BarcodeCategory.PDF417.name) {
      return Barcode.pdf417();
    } else if (widget.category == BarcodeCategory.QRCode.name) {
      return Barcode.qrCode();
    } else if (widget.category == BarcodeCategory.UPC_A.name) {
      return Barcode.upcA();
    } else if (widget.category == BarcodeCategory.UPC_E.name) {
      return Barcode.upcE();
    } else {
      return null;
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: kAppPadding(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomAppbar(
                  title: 'Scanned Barcode',
                  backgroundColor: kScaffoldBgColor(context),
                  titleColor: kSecondaryColor,
                  elevation: 0.0,
                ),

                Padding(
                  padding: EdgeInsets.only(left: 15.r),
                  child: Text(
                    'Scan Date: ${widget.dateScanned}', 
                    style: kNormalTextStyle(context),
                  ),
                ),

                // QR IMAGE
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.r),
                    child: RepaintBoundary(
                      key: _barcodeImageKey,
                      child: widget.imagePath == null ? BarcodeWidget(
                        data: widget.scannedBarcodeData, 
                        barcode: generateBarcode()!,
                        backgroundColor: kScaffoldBgColor(context),
                        color: kSecondaryColor, 
                        style: kNormalTextStyle(context),
                        height: 100.h,
                        width: 250.w,
                      ) : Image.file(
                        File(widget.imagePath!),
                        height: 220.h,
                        width: 250.w,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),

                Divider(thickness: 0.3.r, color: kFontTheme(context)),
                SizedBox(height: 10.r),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        widget.category,
                        style: kYellowNormalTextStyle(context).copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.sp
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Divider(thickness: 0.15.r, color: kFontTheme(context)),

                    SizedBox(height: 10.h),
                    Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Text(
                            'Barcode Data:',
                            style: kYellowNormalTextStyle(context).copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 17.sp,
                            ),
                          ),
                        ),

                        Expanded(
                          flex: 1,
                          child: IconButton(
                            onPressed: () async {
                              await Clipboard.setData(ClipboardData(text: widget.scannedBarcodeData));
                              showSnackbar(context, 'Copied to clipboard.');
                            }, 
                            icon: Icon(
                              Icons.copy,
                              size: 20.r,
                              color: kSecondaryColor,
                            ),
                          )
                        )
                      ],
                    ),

                    Text(
                      widget.scannedBarcodeData,
                      style: kNormalTextStyle(context)
                    ),

                    SizedBox(height: 5.h,)
                  ],
                ),
                Divider(thickness: 0.3.r, color: kFontTheme(context)),
                SizedBox(height: 10.h),

                Row(
                  children: [
                    Platform.isAndroid ? Expanded(
                      child: IconTextButton(
                        text: 'Save QR', 
                        icon: Icons.save, 
                        iconColor: kSecondaryColor,
                        iconsize: 20.r,
                        fontSize: 15.sp,
                        gap: 10.w,
                        onPressed: () {
                          captureAndSaveCode(context, _barcodeImageKey, 'QR Code');
                        },
                      ),
                    ) : const SizedBox(),

                    Expanded(
                      child: IconTextButton(
                        text: 'Share', 
                        icon: Icons.share, 
                        iconColor: kSecondaryColor,
                        iconsize: 20.r,
                        fontSize: 15.sp,
                        gap: 10.w,
                        onPressed: () {
                          Share.share(widget.scannedBarcodeData);
                        },
                      ),
                    ),

                    if(widget.scannedBarcodeData.contains('http://') || widget.scannedBarcodeData.contains('https://')) Expanded(
                      child: IconTextButton(
                        text: 'Open URL', 
                        icon: Icons.open_in_browser, 
                        iconColor: kSecondaryColor,
                        iconsize: 20.r,
                        fontSize: 15.sp,
                        gap: 10.w,
                        onPressed: () {
                          launchUrlFromString(context, widget.scannedBarcodeData);
                        },
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}