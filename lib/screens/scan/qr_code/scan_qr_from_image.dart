// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qr_quill/models/create_code.dart';
import 'package:qr_quill/models/scan_code.dart';
import 'package:qr_quill/screens/scan/qr_code/scan_qr_results.dart';
import 'package:qr_quill/services/isar_db.dart';
import 'package:qr_quill/shared/button.dart';
import 'package:qr_quill/shared/constants.dart';
import 'package:qr_quill/shared/logger.dart';
import 'package:qr_quill/shared/navigator.dart';
import 'package:qr_quill/shared/snackbar.dart';
import 'package:qr_quill/shared/textfield.dart';
import 'package:scan/scan.dart';

class ScanQRFromImage extends StatefulWidget {
  const ScanQRFromImage({super.key});

  @override
  State<ScanQRFromImage> createState() => _ScanQRFromImageState();
}

class _ScanQRFromImageState extends State<ScanQRFromImage> {
  // final _scanController = ScanController();

  String qrData = 'Unknown';
  
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
              padding: kAppPadding(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Please upload a QR Code image.', style: kYellowNormalTextStyle(context)),
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
                      String? imageData = await Scan.parse(mediaPath!);
                      if (imageData != null) {    
                        setState(() {
                          qrData = imageData;
                        });

                        navigatorPushReplacement(
                          context, 
                          ScanQRResults(
                            scannedQrData: qrData, 
                            category: generateCategory().name, 
                            imagePath: mediaPath, 
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