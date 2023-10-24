// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:qr_quill/shared/textfield.dart';

class FileUploadForm extends StatefulWidget {
  const FileUploadForm({super.key});

  @override
  State<FileUploadForm> createState() => _FileUploadFormState();
}

class _FileUploadFormState extends State<FileUploadForm> with SingleTickerProviderStateMixin {
  String? filePath;

  @override
  Widget build(BuildContext context) {
    return FileUploadField(
      filePath: filePath
    );
  }
}
