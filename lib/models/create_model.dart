// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/// Enumerator to hold qrcode categories
enum QRCodeCategory {Wifi, Text, Email, URL, Contact, Event, Image, File, Socials, SMS}

/// Map from QRCodeCategory enum to Icons
const qrCodeCategoryIcons = {
  QRCodeCategory.Wifi: Icons.wifi,
  QRCodeCategory.Text: Icons.text_snippet_rounded,
  QRCodeCategory.Email: Icons.email_rounded,
  QRCodeCategory.URL: Icons.link_rounded,
  QRCodeCategory.Contact: Icons.person_2_sharp,
  QRCodeCategory.Socials: FontAwesomeIcons.link,
  QRCodeCategory.Event: Icons.event,
  QRCodeCategory.Image: Icons.image,
  QRCodeCategory.File: Icons.file_present,
  QRCodeCategory.SMS: FontAwesomeIcons.commentSms,
};

/// Map from QRCodeCategory string data to Icons
Map<String, dynamic> qrCodeCategoryStringDataIcons = {
  QRCodeCategory.Wifi.name: Icons.wifi,
  QRCodeCategory.Text.name: Icons.text_snippet_rounded,
  QRCodeCategory.Email.name: Icons.email_rounded,
  QRCodeCategory.URL.name: Icons.link_rounded,
  QRCodeCategory.Contact.name: Icons.person_2_sharp,
  QRCodeCategory.Socials.name: FontAwesomeIcons.link,
  QRCodeCategory.Event.name: Icons.event,
  QRCodeCategory.Image.name: Icons.image,
  QRCodeCategory.File.name: Icons.file_present,
  QRCodeCategory.SMS.name: FontAwesomeIcons.commentSms,
};

/// Model to be used to add created qrcodes to isar db
class QRCodeModel {
  String type;
  String qrCodeName;
  String category;
  String qrData;
  String stringData;

  QRCodeModel({
    required this.type,
    required this.qrCodeName,
    required this.category,
    required this.qrData,
    required this.stringData,
  });
}


enum BarcodeCategory {QRCode, DataMatrix, PDF417, Aztec, EAN13, EAN8, EAN5, EAN2, UPC_E, UPC_A, Code128, Code93, Code39, Codabar, ITF, ISBN}

/// Model to add created barcodes to isar db
class BarcodeModel {
  String type;
  String barcodeName;
  String category;
  String barcodeData;
  String stringData;

  BarcodeModel({
    required this.type,
    required this.barcodeName,
    required this.category,
    required this.barcodeData,
    required this.stringData,
  });
}