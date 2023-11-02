// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qr_quill/models/create_code.dart';
import 'package:qr_quill/models/scan_code.dart';
import 'package:qr_quill/screens/scan/barcode/scan_barcode_results.dart';
import 'package:qr_quill/services/isar_db.dart';
import 'package:qr_quill/shared/button.dart';
import 'package:qr_quill/shared/constants.dart';
import 'package:qr_quill/shared/logger.dart';
import 'package:qr_quill/shared/navigator.dart';
import 'package:qr_quill/shared/snackbar.dart';
import 'package:qr_quill/shared/textfield.dart';
import 'package:scan/scan.dart';

class ScanBarcodeFromImage extends StatefulWidget {
  const ScanBarcodeFromImage({super.key});

  @override
  State<ScanBarcodeFromImage> createState() => _ScanBarcodeFromImageState();
}

class _ScanBarcodeFromImageState extends State<ScanBarcodeFromImage> {
  // final _scanController = ScanController();

  String barcodeData = 'Unknown';
  
  XFile? pickedMedia;
  String? mediaPath;

  final dateGenerated = DateTime.now().toString().substring(0, 16);

  /// Function to pick an image
  pickImage(ImageSource source) async {
    final imagePicker = ImagePicker();
                                              
    setState(() {
      pickedMedia = null;
    });

    // pick image from file system
    pickedMedia = await imagePicker.pickImage(source: source);

    if (pickedMedia != null) {
      setState(() {
        mediaPath = pickedMedia!.path;
      });
      logger('Selected Image Path: $mediaPath');
      logger('Picked Media: $pickedMedia');
    }
  }

  /// Function to generate category based on qr code data 
  BarcodeCategory generateCategory() {
    return BarcodeCategory.Aztec;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: kAppPadding(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Please upload a Barcode image.', style: kYellowNormalTextStyle(context)),
                  SizedBox(height: 20.h),
                  
                  MediaUploadField(
                    mediaPath: mediaPath, 
                    pickImage: () {
                      pickImage(ImageSource.gallery);
                    },
                  ),

                  Button(
                    buttonText: 'Scan Image', 
                    onPressed: () async {
                      String? image = await Scan.parse(mediaPath!);
                      if (image != null) {    
                        setState(() {
                          barcodeData = image;
                        });

                        navigatorPushReplacement(
                          context, 
                          ScanBarcodeResults(
                            scannedBarcodeData: barcodeData, 
                            category: generateCategory().name, 
                            imagePath: mediaPath, 
                            dateScanned: dateGenerated,
                          )
                        );

                        // add scanned code to isar db
                        IsarDB().addScannedCode(
                          context, 
                          ScanCode(
                            type: 'Barcode',
                            codeName: generateCategory().name,
                            category: generateCategory().name,
                            codeData: barcodeData,
                            datetime: dateGenerated,
                            mediaPath: mediaPath,
                          ),
                        );
                      } else {
                        showSnackbar(context, 'No data detected from this image.');
                      }
                    }, 
                    buttonColor: kSecondaryColor, 
                    inactive: false,
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