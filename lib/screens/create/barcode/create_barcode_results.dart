// ignore_for_file: use_build_context_synchronousl, use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_quill/services/qr_barcode_utility_functions.dart';
import 'package:qr_quill/shared/button.dart';
import 'package:qr_quill/models/create_code.dart';
import 'package:qr_quill/shared/animations.dart';
import 'package:qr_quill/shared/constants.dart';
import 'package:qr_quill/shared/custom_appbar.dart';
import 'package:qr_quill/shared/snackbar.dart';

class ShowBarcode extends StatefulWidget {
  const ShowBarcode({
    super.key, 
    required this.barcodeName,
    required this.selectedCategory,
    required this.barcodeData, 
    required this.dateScanned,
  });

  final String barcodeData;
  final String barcodeName;
  final String selectedCategory;
  final String dateScanned;

  @override
  State<ShowBarcode> createState() => _ShowBarcodeState();
}

class _ShowBarcodeState extends State<ShowBarcode> {
  final GlobalKey _barcodeImageKey = GlobalKey();

  Barcode? generateBarcode() {
    if (widget.selectedCategory == BarcodeCategory.Aztec.name) {
      return Barcode.aztec();
    } else if (widget.selectedCategory == BarcodeCategory.Codabar.name) {
      return Barcode.codabar();
    } else if (widget.selectedCategory == BarcodeCategory.Code128.name) {
      return Barcode.code128();
    } else if (widget.selectedCategory == BarcodeCategory.Code39.name) {
      return Barcode.code39();
    } else if (widget.selectedCategory == BarcodeCategory.Code93.name) {
      return Barcode.code93();
    } else if (widget.selectedCategory == BarcodeCategory.DataMatrix.name) {
      return Barcode.dataMatrix();
    } else if (widget.selectedCategory == BarcodeCategory.EAN13.name) {
      return Barcode.ean13();
    } else if (widget.selectedCategory == BarcodeCategory.EAN8.name) {
      return Barcode.ean8();
    } else if (widget.selectedCategory == BarcodeCategory.EAN5.name) {
      return Barcode.ean5();
    } else if (widget.selectedCategory == BarcodeCategory.EAN2.name) {
      return Barcode.ean2();
    } else if (widget.selectedCategory == BarcodeCategory.ISBN.name) {
      return Barcode.isbn();
    } else if (widget.selectedCategory == BarcodeCategory.ITF.name) {
      return Barcode.itf();
    } else if (widget.selectedCategory == BarcodeCategory.PDF417.name) {
      return Barcode.pdf417();
    } else if (widget.selectedCategory == BarcodeCategory.QRCode.name) {
      return Barcode.qrCode();
    } else if (widget.selectedCategory == BarcodeCategory.UPC_A.name) {
      return Barcode.upcA();
    } else if (widget.selectedCategory == BarcodeCategory.UPC_E.name) {
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
                  title: 'Generated Barcode',
                  backgroundColor: kScaffoldBgColor(context),
                  titleColor: kSecondaryColor,
                  elevation: 0.0,
                ),

                Padding(
                  padding: EdgeInsets.only(left: 15.r),
                  child: Text(
                    'Date Generated: ${widget.dateScanned}', 
                    style: kNormalTextStyle(context),
                  ),
                ),

                // QR IMAGE
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.r),
                    child: RepaintBoundary(
                      key: _barcodeImageKey,
                      child: BarcodeWidget(
                        data: widget.barcodeData, 
                        barcode: generateBarcode()!,
                        backgroundColor: kScaffoldBgColor(context),
                        color: kSecondaryColor, 
                        style: kNormalTextStyle(context),
                        height: 100.h,
                        width: 250.w,
                      )
                    ),
                  ),
                ),

                Divider(thickness: 0.3.r, color: kFontTheme(context)),
                SizedBox(height: 10.r),

                // QR DATA
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        widget.selectedCategory,
                        style: kYellowNormalTextStyle(context).copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.sp
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Divider(thickness: 0.15.r, color: kFontTheme(context)),

                    SizedBox(height: 10.h),
                    Text(
                      'Barcode Name:',
                      style: kYellowNormalTextStyle(context).copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 17.sp,
                      ),
                    ),

                    Text(
                      widget.barcodeName,
                      style: kNormalTextStyle(context)
                    ),
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
                              await Clipboard.setData(ClipboardData(text: widget.barcodeData));
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
                      widget.barcodeData,
                      style: kNormalTextStyle(context)
                    ),

                    SizedBox(height: 5.h,)
                  ],
                ),
                Divider(thickness: 0.3.r, color: kFontTheme(context)),
                SizedBox(height: 10.h),

                // Share QR Code and open URL 
                Row(
                  children: [
                    Platform.isAndroid ? Expanded(
                      child: IconTextButton(
                        text: 'Save', 
                        icon: Icons.save, 
                        iconColor: kSecondaryColor,
                        iconsize: 20.r,
                        fontSize: 15.sp,
                        gap: 10.w,
                        onPressed: () {
                          captureAndSaveCode(context, _barcodeImageKey, 'Barcode');
                        },
                      ),
                    ) : const SizedBox(),

                    Expanded(
                      child: IconTextButton(
                        text: 'Share', 
                        icon: Icons.share, 
                        iconColor: kSecondaryColor, 
                        fontSize: 15.sp,
                        iconsize: 20.r,
                        gap: 10.w,
                        onPressed: () {
                          captureAndShareCode(context, _barcodeImageKey);
                        },
                      ),
                    ),

                    if (widget.barcodeData.contains('https://') || widget.barcodeData.contains('http://')) Expanded(
                      child: IconTextButton(
                        text: 'Open URL', 
                        icon: Icons.open_in_browser, 
                        iconColor: kSecondaryColor, 
                        fontSize: 15.sp,
                        iconsize: 20.r,
                        gap: 10.w,
                        onPressed: () {
                          launchUrlFromString(context, widget.barcodeData);
                        }
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 20.h),
                
              ].animate(
                interval: kAnimationDurationMs(200),
                effects: MyEffects.fadeSlide(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}