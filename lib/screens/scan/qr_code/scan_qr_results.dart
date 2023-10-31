// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qr_quill/models/create_code.dart';
import 'package:qr_quill/services/qr_barcode_utility_functions.dart';
import 'package:qr_quill/shared/button.dart';
import 'package:qr_quill/shared/constants.dart';
import 'package:qr_quill/shared/custom_appbar.dart';
import 'package:qr_quill/shared/logger.dart';
import 'package:qr_quill/shared/snackbar.dart';
import 'package:share_plus/share_plus.dart';

class ScanQRResults extends StatefulWidget {
  const ScanQRResults({
    super.key, 
    required this.scannedQrData, 
    required this.category, 
    this.imagePath,
    required this.dateScanned,
  });

  final String scannedQrData;
  final String? imagePath;
  final String category;
  final String dateScanned;

  @override
  State<ScanQRResults> createState() => _ScanQRResultsState();
}

class _ScanQRResultsState extends State<ScanQRResults> {
  final _qrImageKey = GlobalKey();
  final dateScanned = DateTime.now().toString().substring(0, 16);



  Uri sendEmail() {
    Uri uri = Uri.parse(widget.scannedQrData);
    final Uri params = Uri(
      scheme: 'mailto',
      path: uri.path,
      queryParameters: {
        'subject': uri.queryParameters['subject'],
        'body': uri.queryParameters['body']
      }
    );

    logger(uri.path);
    logger(params.toString().replaceAll('+', ' '));

    return Uri.parse(params.toString().replaceAll('+', ' '));
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
                  title: 'Scanned QR Code',
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
                      key: _qrImageKey,
                      child: widget.imagePath == null ? QrImageView(
                        data: widget.scannedQrData,
                        size: 220.r,
                        eyeStyle: QrEyeStyle(
                          color: kSecondaryColor,
                          eyeShape: QrEyeShape.circle,
                        ),
                        dataModuleStyle: QrDataModuleStyle(
                          color: kSecondaryColor,
                          dataModuleShape: QrDataModuleShape.circle
                        ),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          qrCodeCategoryStringDataIcons[widget.category],
                          color: kSecondaryColor,
                          size: 35.r,
                        ),

                        SizedBox(width: 10.w),

                        Text(
                          widget.category,
                          style: kYellowNormalTextStyle(context).copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.sp
                          ),
                        )
                      ]
                    ),
                    SizedBox(height: 10.h),
                    Divider(thickness: 0.15.r, color: kFontTheme(context)),

                    SizedBox(height: 10.h),
                    Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Text(
                            'QR Code Data:',
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
                              await Clipboard.setData(ClipboardData(text: widget.scannedQrData));
                              showSnackbar(context, 'Copied to clipboard.');
                            }, 
                            icon: Icon(
                              Icons.copy_rounded,
                              size: 20.r,
                              color: kSecondaryColor,
                            ),
                          )
                        )
                      ],
                    ),

                    Text(
                      widget.scannedQrData,
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
                          captureAndSaveCode(context, _qrImageKey, 'QR Code');
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
                          // captureAndShareCode(context, _qrImageKey);
                          Share.share(widget.scannedQrData);
                        },
                      ),
                    ),

                    if(widget.category == QRCodeCategory.Email.name) Expanded(
                      child: IconTextButton(
                        text: 'Send Email', 
                        icon: Icons.email_rounded, 
                        iconColor: kSecondaryColor,
                        iconsize: 20.r,
                        fontSize: 15.sp,
                        gap: 10.w,
                        onPressed: () {
                          // launchUrlFromUri(context, sendEmail());
                          launchUrlFromUri(context, Uri.parse(Uri.encodeFull(widget.scannedQrData)));
                        },
                      ),
                    ),

                    if(widget.category == QRCodeCategory.SMS.name) Expanded(
                      child: IconTextButton(
                        text: 'Send SMS', 
                        icon: FontAwesomeIcons.commentSms, 
                        iconColor: kSecondaryColor,
                        iconsize: 20.r,
                        fontSize: 15.sp,
                        gap: 10.w,
                        onPressed: () {
                          // launchUrlFromUri(context, sendEmail());
                        },
                      ),
                    ),

                    if(widget.category == QRCodeCategory.URL.name) Expanded(
                      child: IconTextButton(
                        text: 'Open URL', 
                        icon: Icons.open_in_browser, 
                        iconColor: kSecondaryColor,
                        iconsize: 20.r,
                        fontSize: 15.sp,
                        gap: 10.w,
                        onPressed: () {
                          launchUrlFromString(context, widget.scannedQrData);
                        },
                      ),
                    ),

                    if(widget.category == QRCodeCategory.Event.name) Expanded(
                      child: IconTextButton(
                        text: 'Save in Calendar', 
                        icon: Icons.calendar_month, 
                        iconColor: kSecondaryColor,
                        iconsize: 20.r,
                        fontSize: 15.sp,
                        gap: 10.w,
                        onPressed: () {
                          // launchUrlFromString(context, widget.scannedQrData);
                        },
                      ),
                    ),

                    if(widget.category == QRCodeCategory.Wifi.name) Expanded(
                      child: IconTextButton(
                        text: 'Connect', 
                        icon: Icons.wifi, 
                        iconColor: kSecondaryColor,
                        iconsize: 20.r,
                        fontSize: 15.sp,
                        gap: 10.w,
                        onPressed: () {
                          launchUrlFromUri(context, Uri.parse(widget.scannedQrData));
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