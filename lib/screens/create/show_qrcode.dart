// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share_plus/share_plus.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_quill/shared/button.dart';
import 'package:qr_quill/shared/logger.dart';
import 'package:qr_quill/shared/snackbar.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qr_quill/models/qrcode_model.dart';
import 'package:qr_quill/shared/animations.dart';
import 'package:qr_quill/shared/constants.dart';
import 'package:qr_quill/shared/custom_appbar.dart';

class ShowQRCode extends StatefulWidget {
  const ShowQRCode({
    super.key, 
    required this.qrCodeName,
    required this.selectedCategory,
    required this.qrData, 
    required this.stringData,
  });

  final String qrData;
  final String stringData;
  final String qrCodeName;
  final Category selectedCategory;

  @override
  State<ShowQRCode> createState() => _ShowQRCodeState();
}

class _ShowQRCodeState extends State<ShowQRCode> {
  final GlobalKey qrImageKey = GlobalKey();

  /// Function to launch URL
  launchUrl() async {
    // Uri url = Uri.parse(widget.qrData);
    String url = widget.qrData;

    try {
      if (await canLaunchUrlString(url)) {
        await launchUrlString(url);
      } else {
        throw 'Unable to load url.';
        // showSnackbar(context, 'Cannot launch this URL.');
      }
    } catch (e) {
      showSnackbar(context, 'An error occured while trying to load the URL.');
      logger(e.toString());
    }
  }

  /// Function to capture QR Code and share
  Future<void> captureAndShareQRCode() async {
    RenderRepaintBoundary boundary = qrImageKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage(pixelRatio: 3.0);
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData!.buffer.asUint8List();

    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/qr_code.png');
    await file.writeAsBytes(pngBytes);

    XFile xFile = XFile(file.path);
    Share.shareXFiles(
      [xFile],
      subject: 'Check this out',
      text: 'QR Code Image',
      sharePositionOrigin: Rect.fromPoints(const Offset(0, 0), const Offset(0, 0))
    );
  }

  @override
  Widget build(BuildContext context) {
    // Map qrData = jsonDecode(widget.data);
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: kAppPadding(),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomAppbar(
                  title: 'Generated QR Code',
                  backgroundColor: kScaffoldBgColor(context),
                  titleColor: kSecondaryColor,
                  elevation: 0.0,
                ),

                // QR IMAGE
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.r),
                    child: RepaintBoundary(
                      key: qrImageKey,
                      child: QrImageView(
                        data: widget.qrData,
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

                // QR DATA
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          categoryIcons[widget.selectedCategory],
                          color: kSecondaryColor,
                          size: 35.r,
                        ),

                        SizedBox(width: 25.w),

                        Text(
                          widget.selectedCategory.name,
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
                      'QR Code Name:',
                      style: kYellowNormalTextStyle(context).copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.sp,
                      ),
                    ),

                    Text(
                      widget.qrCodeName,
                      style: kNormalTextStyle(context)
                    ),
                    SizedBox(height: 10.h),

                    Text(
                      'QR Code Data:',
                      style: kYellowNormalTextStyle(context).copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.sp,
                      ),
                    ),

                    // DIsplay Image
                    if (widget.selectedCategory == Category.Image)  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 18.0),
                      child: Center(
                        child: Image(
                          image: NetworkImage(widget.qrData),
                          height: 300.h,
                          width: 300.w,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),


                    // File
                    if (widget.selectedCategory == Category.File)  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Text(
                        'File:\n${widget.stringData}',
                        style: kNormalTextStyle(context),
                        textAlign: TextAlign.justify,
                      ),
                    ),

                    // Download button for images and files
                    widget.selectedCategory == Category.File || widget.selectedCategory == Category.Image 
                    ? IconTextButton(
                        onPressed: launchUrl, 
                        icon: FontAwesomeIcons.download,
                        text: 'Download',
                        iconColor: kSecondaryColor,
                        fontSize: 17.sp,
                    ): Text(
                      widget.stringData,
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
                    Expanded(
                      child: IconTextButton(
                        text: 'Share', 
                        icon: Icons.share, 
                        iconColor: kSecondaryColor, 
                        fontSize: 17.sp,
                        onPressed: captureAndShareQRCode,
                      ),
                    ),

                    if(widget.selectedCategory == Category.URL || widget.selectedCategory == Category.Socials) Expanded(
                      child: IconTextButton(
                        text: 'Open URL', 
                        icon: Icons.open_in_browser, 
                        iconColor: kSecondaryColor, 
                        fontSize: 17.sp,
                        onPressed: launchUrl
                      ),
                    )
                  ],
                ),

                SizedBox(height: 20.h),
                
              ].animate(
                interval: kAnimationDurationMs(500),
                effects: MyEffects.fadeSlide(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}