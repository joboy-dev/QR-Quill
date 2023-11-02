// ignore_for_file: constant_identifier_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:qr_quill/models/create_code.dart';
import 'package:qr_quill/screens/scan/barcode/scan_barcode_results.dart';
// import 'package:qr_quill/screens/scan/barcode/scan_barcode_from_image.dart';
// import 'package:qr_quill/screens/scan/barcode/scan_barcode_with_camera.dart';
import 'package:qr_quill/screens/scan/qr_code/scan_qr_from_image.dart';
import 'package:qr_quill/screens/scan/qr_code/scan_qr_results.dart';
import 'package:qr_quill/screens/scan/qr_code/scan_qr_with_camera.dart';
import 'package:qr_quill/screens/scan/scan_code_menu.dart';
import 'package:qr_quill/services/isar_db.dart';
import 'package:qr_quill/services/provider/scan_code_provider.dart';
import 'package:qr_quill/shared/animations.dart';
import 'package:qr_quill/shared/button.dart';
import 'package:qr_quill/shared/constants.dart';
import 'package:qr_quill/shared/custom_appbar.dart';
import 'package:qr_quill/shared/navigator.dart';
import 'package:qr_quill/shared/snackbar.dart';

class Scan extends StatefulWidget {
  const Scan({super.key});

  static const String id = 'scan';

  @override
  State<Scan> createState() => _ScanState();
}

class _ScanState extends State<Scan> {

  @override
  Widget build(BuildContext context) {
    // logger(kHeightWidth(context).height);

    final scannedCodes = context.watch<ScanCodeProvider>().scannedCodes;
    final isarDb = IsarDB();

    return Scaffold(
      body: Padding(
        padding: kAppPadding(),
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
                      onPressed: () {
                        navigatorPush(context, ScanCodeMenu(
                          scanWithCameraNavTo: () {
                            navigatorPush(context, const ScanQRWithCamera());
                          },
                          scanFromImageNavTo: () {
                            navigatorPush(context, const ScanQRFromImage());
                          },
                        ));
                      },
                      buttonColor: kSecondaryColor,
                      icon: Icons.qr_code_scanner_rounded
                    ),
                  ),

                  // SizedBox(width: 20.w),

                  // Expanded(
                  //   child: ColumnButtonIcon(
                  //     buttonText: 'Scan Barcode',
                  //     onPressed: () {
                  //       navigatorPush(context, ScanCodeMenu(
                  //         scanWithCameraNavTo: () {
                  //           navigatorPush(context, const ScanBarcodeWithCamera());
                  //           // scanBarcode();
                  //         },

                  //         scanFromImageNavTo: () {
                  //           navigatorPush(context, const ScanBarcodeFromImage());
                  //         },
                  //       ));
                  //     },
                  //     buttonColor: kSecondaryColor,
                  //     icon: Icons.barcode_reader,
                  //   ),
                  // )
                ]
              )
            ),
            SizedBox(height: 15.h),
            Center(
              child: Text(
                'Scan barcode feature coming later.', 
                style: kYellowNormalTextStyle(context),
              )
            ),
            SizedBox(height: 15.h),

            Expanded(
              flex: 4,
              child: Column(
                children: [
                  CustomAppbar(
                    title: 'Scan History',
                    titleColor: kSecondaryColor,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    elevation: 0.0,
                  ),
                  SizedBox(height: 5.h),

                  SizedBox(
                    height: kHeightWidth(context).height * 0.46,
                    child: scannedCodes.isNotEmpty ? Padding(
                      padding: kAppPadding().copyWith(top: 0.0),
                      child: ListView.builder(
                        itemCount: scannedCodes.length,
                        itemBuilder: (context, index)  {
                          final reversedIndex = scannedCodes.length - 1 - index;
                          final code = scannedCodes[reversedIndex];
                          return GestureDetector(
                            onTap: () {
                              navigatorPush(
                                context, 
                                code.type == 'QR Code' ? 
                                ScanQRResults(
                                  dateScanned: code.datetime!,
                                  scannedQrData: code.codeData!,
                                  category: code.category!,
                                  imagePath: code.mediaPath,
                              ): ScanBarcodeResults(
                                  imagePath: code.mediaPath, 
                                  category: code.category!, 
                                  scannedBarcodeData: code.codeData!,
                                  dateScanned: code.datetime!,
                                )
                             );
                            },
                            child: Dismissible(
                              key: ValueKey(code),
                              background: Card(
                                color: kRedColor,
                                margin: EdgeInsets.only(bottom: 15.r),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20.r),
                                  child: Row(
                                    children: [
                                      const Spacer(),
                                      Text(
                                        'Swipe to delete', 
                                        style: kNormalTextStyle(context).copyWith(
                                          color: kTertiaryColor,
                                        ),
                                      ),
                                      Icon(Icons.delete, size: 30.r, color: kTertiaryColor,)
                                    ],
                                  ),
                                ),
                              ),
                              onDismissed: (direction) async {
                                final codeToDelete = await isarDb.getSingleScannedCode(code.id);
                                // delete the code from isar db
                                await isarDb.deleteScannedCode(context, code.id);

                                showSnackbar(
                                    context, 
                                    'Code deleted.', 
                                    action: SnackBarAction(
                                      label: 'Undo', 
                                      onPressed: () async {
                                        if (codeToDelete != null) {
                                          await isarDb.addScannedCode(context, codeToDelete);
                                          await isarDb.getScannedCodes(context);
                                          showSnackbar(context, 'Undo successful');
                                        } else {
                                          showSnackbar(context, 'The deleted code could not be brought back.');
                                        }
                                      },
                                      backgroundColor: kSecondaryColor,
                                      textColor: kPrimaryColor,
                                  ),
                                );
                              },
                              child: Card(
                                color: kScaffoldBgColor(context),
                                surfaceTintColor: kScaffoldBgColor(context),
                                margin: EdgeInsets.only(bottom: 15.r),
                                shadowColor: kSecondaryColor,
                                elevation: 1.0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.r),
                                  side: BorderSide(
                                    color: kFontTheme(context),
                                    width: 1.w,
                                  )
                                ),
                                child: Padding(
                                  padding: kAppPadding().copyWith(bottom: 15.r),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Icon(
                                          code.type == 'QR Code' 
                                          ? qrCodeCategoryStringDataIcons[code.category]
                                          : FontAwesomeIcons.barcode, 
                                          size: 25.r, 
                                          color: kSecondaryColor
                                        ),
                                      ),
                            
                                      // CODE DATA
                                      Expanded(
                                        flex: 4,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  code.type!,
                                                  style: kYellowNormalTextStyle(context).copyWith(
                                                    fontSize: 17.sp,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                      
                                                // Text(
                                                //   '- ${code.category!}',
                                                //   style: kNormalTextStyle(context).copyWith(
                                                //     fontSize: 17.sp,
                                                //     fontWeight: FontWeight.bold,
                                                //   ),
                                                // ),
                                              ],
                                            ),
                                                      
                                            Text(
                                              code.codeData!.length <= 25
                                              ? code.codeData!.replaceAll('\n', ' ')
                                              :'${code.codeData!.replaceAll('\n', ' ').substring(0, 25)}...',
                                              style: kNormalTextStyle(context),
                                            ),
                                          ],
                                        )
                                      ),              
                                    ],
                                  ),
                                ),
                              ).animate(
                                delay: kAnimationDurationMs(100),
                                effects: MyEffects.fadeSlide(offset: const Offset(-0.1, 0.0))
                              ),
                            ),
                          );
                        },
                      ),
                    ) : Center(
                      child: Text(
                        'You have no created codes.',
                        style: kNormalTextStyle(context),
                      ),
                    ),
                  ),
                ],
              )
            )
          ].animate(
            delay: kAnimationDurationMs(500),
            interval: kAnimationDurationMs(200),
            effects: MyEffects.fadeSlide(offset: const Offset(0.0, -0.1))
          ),
        ),
      ),
    );
  }
}