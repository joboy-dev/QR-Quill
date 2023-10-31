// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qr_quill/models/create_code.dart';
import 'package:qr_quill/screens/create/qr_code/create_qr_results.dart';
import 'package:qr_quill/services/cloud_storage.dart';
import 'package:qr_quill/services/isar_db.dart';
import 'package:qr_quill/shared/animations.dart';
import 'package:qr_quill/shared/button.dart';
import 'package:qr_quill/shared/constants.dart';
import 'package:qr_quill/shared/loader.dart';
import 'package:qr_quill/shared/logger.dart';
import 'package:qr_quill/shared/navigator.dart';
import 'package:qr_quill/shared/snackbar.dart';
import 'package:qr_quill/shared/textfield.dart';

class ImageForm extends StatefulWidget {
  const ImageForm({super.key, required this.qrCodeName});

  final String qrCodeName;

  @override
  State<ImageForm> createState() => _ImageFormState();
}

class _ImageFormState extends State<ImageForm> {
  final _formKey = GlobalKey<FormState>();

  // Image
  String? mediaPath;
  XFile? pickedMedia;

  final cloudStorage = CloudStorage();

  bool isLoading = false;
  final isarDb = IsarDB();
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

  validateForm() async {
    if (pickedMedia != null) {
      setState(() {
        isLoading = true;
      });

      showSnackbar(context, 'Generating Qr Code...');
      String downloadUrl = await cloudStorage.uploadImage(pickedMedia);

      setState(() {
        isLoading = false;
      });
      logger(downloadUrl);

      navigatorPushReplacement(context, ShowQRCode(
          qrCodeName: widget.qrCodeName ,
          selectedCategory: QRCodeCategory.Image.name, 
          qrData: downloadUrl, 
          stringData: downloadUrl,
          dateGenerated: dateGenerated,
        )
      );

      await isarDb.addCreatedCode(
        context, 
        CreateCode(
          type: 'QR Code',
          codeName: widget.qrCodeName,
          category: QRCodeCategory.Image.name,
          codeData: downloadUrl,
          stringData: downloadUrl,
          datetime: dateGenerated,
        ),
      );
    } else {
      showSnackbar(context, 'Please select an image');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Text(
            'Please ensure you have an Internet Connection', 
            style: kYellowNormalTextStyle(context).copyWith(
              fontSize: 17.0,
            )
          ),
          SizedBox(height: 10.h),

          MediaUploadField(
            mediaPath: mediaPath, 
            pickImage: () {
              pickImage(ImageSource.gallery);
            }
          ),

          Row(
            children: [
              Expanded(
                child: Button(
                  buttonColor: kSecondaryColor,
                  buttonText: 'Take Photo',
                  onPressed: () {
                    pickImage(ImageSource.camera);
                  },
                  inactive: false,
                )
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Button(
                  buttonColor: kSecondaryColor,
                  buttonText: 'Generate QR',
                  onPressed: validateForm,
                  inactive: false,
                ),
              ),
            ],
          ),

          SizedBox(height:10.h),
          isLoading ? Padding(
            padding: EdgeInsets.only(bottom: 20.h),
            child: const Loader(),
          ) : const SizedBox(),
        ].animate(
          interval: kAnimationDurationMs(100),
          effects: MyEffects.fadeSlide(),
        ),
      ),
    );
  }
}