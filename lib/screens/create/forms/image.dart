// ignore_for_file: avoid_print, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:qr_quill/shared/animations.dart';
import 'package:qr_quill/shared/textfield.dart';

class ImageUploadForm extends StatefulWidget {
  ImageUploadForm({super.key, required this.mediaPath});

  String? mediaPath;

  @override
  State<ImageUploadForm> createState() => _ImageUploadFormState();
}

class _ImageUploadFormState extends State<ImageUploadForm> with SingleTickerProviderStateMixin {
  String? mediaPath;

  @override
  Widget build(BuildContext context) {
    return MediaUploadField(
      mediaPath: widget.mediaPath
    ).animate(
      effects: MyEffects.fadeSlide(offset: const Offset(-0.05, 0)),
    );
  }
}
