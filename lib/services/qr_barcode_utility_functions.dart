// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:ui' as ui;

import 'package:path_provider/path_provider.dart';
import 'package:qr_quill/shared/logger.dart';
import 'package:qr_quill/shared/snackbar.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

/// Function to capture QR Code and share
Future<void> captureAndShareQRCode(GlobalKey imageKey) async {
  // Capture qr code image from qidget using imageKey
  RenderRepaintBoundary boundary = imageKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
  // create image from captured boundary
  ui.Image image = await boundary.toImage(pixelRatio: 3.0);
  // create representation of image as bytedata
  ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
  // getimage data from bytesData and convert into Uint8List
  Uint8List pngBytes = byteData!.buffer.asUint8List();

  final tempDir = await getTemporaryDirectory();
  final file = File('${tempDir.path}/qr_code.png');
  await file.writeAsBytes(pngBytes);

  XFile xFile = XFile(file.path);

  // Share qr code
  Share.shareXFiles(
    [xFile],
    subject: 'Check this out',
    text: 'QR Code Image',
    sharePositionOrigin: Rect.fromPoints(const Offset(0, 0), const Offset(0, 0))
  );
}

/// Function to launch URL
launchUrlFromString(BuildContext context, String url) async {
  try {
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      showSnackbar(context, 'Cannot launch this URL.');
      throw 'Unable to load url.';
    }
  } catch (e) {
    showSnackbar(context, 'An error occured. Please try again later.');
    logger(e.toString());
  }
}

launchUrlFromUri(BuildContext context, Uri uri) async {
  try {
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      showSnackbar(context, 'Cannot launch this URL.');
      throw 'Unable to load url.';
    }
  } catch (e) {
    showSnackbar(context, 'An error occured. Please try again later.');
    logger(e.toString());
  }
}