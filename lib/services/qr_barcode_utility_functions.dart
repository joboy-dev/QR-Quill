// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;

import 'package:path_provider/path_provider.dart';
import 'package:qr_quill/shared/logger.dart';
import 'package:qr_quill/shared/snackbar.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

/// Function to capture code and share
Future<void> captureAndShareCode(BuildContext context, GlobalKey imageKey) async {
  try {
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
      // subject: 'Check this out',
      // text: 'QR Code Image',
      sharePositionOrigin: Rect.fromPoints(const Offset(0, 0), const Offset(0, 0))
    );
  } catch (e) {
    logger(e.toString());
    showSnackbar(context, 'An error occured while trying to share this code.');
  }
}

/// Function to capture code and save
Future<void> captureAndSaveCode(BuildContext context, GlobalKey imageKey, String codeType) async {
  try {
    // Capture qr code image from qidget using imageKey
    RenderRepaintBoundary boundary = imageKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    // create image from captured boundary
    ui.Image image = await boundary.toImage(pixelRatio: 3.0);
    // create representation of image as bytedata
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    // getimage data from bytesData and convert into Uint8List
    Uint8List pngBytes = byteData!.buffer.asUint8List();

    // DEBUGGING
    final externalStorageDirs = await getExternalStorageDirectories(type: StorageDirectory.dcim);
    final externalStorage = externalStorageDirs![0];
    logger(externalStorage);

    // get device external DCIM storage
    const externalStorageDir = 'storage/emulated/0/DCIM';

    // create a custom directory to save image
    final customDir = Directory('$externalStorageDir/QR Quill');
    // final customDir = Directory('${externalStorageDir.path}/QR Quill');
    await customDir.create(recursive: true);

    final file = File('${customDir.path}/${codeType}_${DateTime.now().millisecondsSinceEpoch}.png');
    // write pngBytes to file
    await file.writeAsBytes(pngBytes);

    showSnackbar(context, 'Saved to ${file.path}');
  } catch (e) {
    logger(e.toString());
    showSnackbar(context, 'An error occured while trying to share this code.');
  }
}

/// Function to launch URL
launchUrlFromString(BuildContext context, String url) async {
  logger(url);
  try {
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      showSnackbar(context, 'Cannot launch this URL.');
      // throw 'Unable to load url.';
    }
  } catch (e) {
    showSnackbar(context, 'An error occured. Please try again later.');
    logger(e.toString());
  }
}

launchUrlFromUri(BuildContext context, Uri uri) async {
  logger(uri);
  try {
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      showSnackbar(context, 'Cannot launch this URL.');
      // throw 'Unable to load url.';
    }
  } catch (e) {
    showSnackbar(context, 'An error occured. Please try again later.');
    logger(e.toString());
  }
}