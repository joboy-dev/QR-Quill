import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qr_quill/models/qrcode_model.dart';
import 'package:qr_quill/services/qr_barcode_utility_functions.dart';
import 'package:qr_quill/shared/button.dart';
import 'package:qr_quill/shared/constants.dart';
import 'package:qr_quill/shared/custom_appbar.dart';
import 'package:qr_quill/shared/logger.dart';

class ScanQRResults extends StatefulWidget {
  const ScanQRResults({super.key, required this.scannedQrData, required this.category});

  final String scannedQrData;
  final Category category;

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
    logger(params.toString());

    return params;
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
                    'Scan Date: $dateScanned', 
                    style: kNormalTextStyle(context),
                  ),
                ),

                // QR IMAGE
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.r),
                    child: RepaintBoundary(
                      key: _qrImageKey,
                      child: QrImageView(
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
                          categoryIcons[widget.category],
                          color: kSecondaryColor,
                          size: 35.r,
                        ),

                        SizedBox(width: 10.w),

                        Text(
                          widget.category.name,
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
                    Text(
                      'QR Code Data:',
                      style: kYellowNormalTextStyle(context).copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 17.sp,
                      ),
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
                    Expanded(
                      child: IconTextButton(
                        text: 'Share', 
                        icon: Icons.share, 
                        iconColor: kSecondaryColor, 
                        fontSize: 17.sp,
                        onPressed: () {
                          captureAndShareQRCode(_qrImageKey);
                        },
                      ),
                    ),

                    if(widget.category == Category.Email) Expanded(
                      child: IconTextButton(
                        text: 'Send email', 
                        icon: Icons.email_rounded, 
                        iconColor: kSecondaryColor, 
                        fontSize: 17.sp,
                        onPressed: () {
                          launchUrlFromUri(context, sendEmail());
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}