// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

class FileForm extends StatefulWidget {
  const FileForm({super.key, required this.qrCodeName});

  final String qrCodeName;

  @override
  State<FileForm> createState() => _FileFormState();
}

class _FileFormState extends State<FileForm> {
  final _formKey = GlobalKey<FormState>();

  // File
  String? filePath;
  FilePickerResult? pickedFile;

  final cloudStorage = CloudStorage();

  bool isLoading = false;
  final isarDb = IsarDB();
  final dateGenerated = DateTime.now().toString().substring(0, 16);
  
  /// Function to pick a file
  pickFile() async {
    final filePicker = FilePicker.platform;

    setState(() {
      pickedFile = null;
    });

    // pick image from file system
    pickedFile = await filePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx', 'ppt', 'pptx', 'svg', 'xlsx', 'xls', 'zip', 'rar', 'txt'],
    );

    if (pickedFile != null) {
      File file = File(pickedFile!.files.single.path!);
      setState(() {
        filePath = file.path;
      });

      logger('Selected File Path: $filePath');
      logger('Selected File: $pickedFile');
    }
  }

  validateForm() async {
    if (pickedFile != null) {
      setState(() {
        isLoading = true;
      });

      showSnackbar(context, 'Generating Qr Code...');
      String downloadUrl = await cloudStorage.uploadFile(pickedFile);
      
      setState(() {
        isLoading = false;
      });
      logger(downloadUrl);

      navigatorPushReplacement(context, ShowQRCode(
          qrCodeName: widget.qrCodeName, 
          selectedCategory: QRCodeCategory.File.name, 
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
          category: QRCodeCategory.File.name,
          codeData: downloadUrl,
          stringData: downloadUrl,
          datetime: dateGenerated,
        ),
      );
    } else {
      showSnackbar(context, 'Please select a file');
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
          FileUploadField(
            filePath: filePath,
            pickFile: pickFile,
          ),
          Button(
            buttonColor: kSecondaryColor,
            buttonText: 'Generate QR Code',
            onPressed: validateForm,
            inactive: false,
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