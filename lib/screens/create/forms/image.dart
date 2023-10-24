// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:qr_quill/shared/textfield.dart';

class ImageUploadForm extends StatefulWidget {
  const ImageUploadForm({super.key});

  @override
  State<ImageUploadForm> createState() => _ImageUploadFormState();
}

class _ImageUploadFormState extends State<ImageUploadForm> with SingleTickerProviderStateMixin {
  String? mediaPath;

  @override
  Widget build(BuildContext context) {
    return MediaUploadField(
      mediaPath: mediaPath
    );
  }
}
