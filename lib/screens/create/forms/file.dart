// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:qr_quill/shared/animations.dart';
import 'package:qr_quill/shared/textfield.dart';

// ignore: must_be_immutable
class FileUploadForm extends StatefulWidget {
  FileUploadForm({super.key, required this.filePath});

  String? filePath;

  @override
  State<FileUploadForm> createState() => _FileUploadFormState();
}

class _FileUploadFormState extends State<FileUploadForm> with SingleTickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    return FileUploadField(
      filePath: widget.filePath
    ).animate(
      effects: MyEffects.fadeSlide(offset: const Offset(-0.05, 0)),
    );
  }
}
