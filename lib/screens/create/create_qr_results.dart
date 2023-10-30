// ignore_for_file: use_build_context_synchronousl, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qr_quill/services/qr_barcode_utility_functions.dart';
import 'package:qr_quill/shared/button.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qr_quill/models/create_model.dart';
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
  final GlobalKey _qrImageKey = GlobalKey();
  final dateGenerated = DateTime.now().toString().substring(0, 16);

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
                  title: 'Generated QR Code',
                  backgroundColor: kScaffoldBgColor(context),
                  titleColor: kSecondaryColor,
                  elevation: 0.0,
                ),

                Padding(
                  padding: EdgeInsets.only(left: 15.r),
                  child: Text(
                    'Date Generated: $dateGenerated', 
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

                        SizedBox(width: 10.w),

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
                        fontSize: 17.sp,
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
                        fontSize: 17.sp,
                      ),
                    ),

                    // DIsplay Image
                    if (widget.selectedCategory == Category.Image)  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 18.0),
                      child: Center(
                        child:  Image(
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
                        'File Source:\n\n${widget.stringData}\n',
                        style: kNormalTextStyle(context),
                        textAlign: TextAlign.justify,
                      ),
                    ),

                    // Download button for images and files
                    widget.selectedCategory == Category.File || widget.selectedCategory == Category.Image 
                    ? IconTextButton(
                        onPressed: () {
                          launchUrlFromString(context, widget.qrData);
                        }, 
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
                        text: 'Save QR', 
                        icon: Icons.save, 
                        iconColor: kSecondaryColor,
                        iconsize: 20.r,
                        fontSize: 15.sp,
                        gap: 10.w,
                        onPressed: () {
                          // captureAndShareQRCode(_qrImageKey);
                        },
                      ),
                    ),

                    Expanded(
                      child: IconTextButton(
                        text: 'Share', 
                        icon: Icons.share, 
                        iconColor: kSecondaryColor, 
                        fontSize: 15.sp,
                        iconsize: 20.r,
                        gap: 10.w,
                        onPressed: () {
                          captureAndShareQRCode(_qrImageKey);
                        },
                      ),
                    ),

                    if(widget.selectedCategory == Category.URL || widget.selectedCategory == Category.Socials) Expanded(
                      child: IconTextButton(
                        text: 'Open URL', 
                        icon: Icons.open_in_browser, 
                        iconColor: kSecondaryColor, 
                        fontSize: 15.sp,
                        iconsize: 20.r,
                        gap: 10.w,
                        onPressed: () {
                          launchUrlFromString(context, widget.qrData);
                        }
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