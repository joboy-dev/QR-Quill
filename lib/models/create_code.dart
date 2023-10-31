// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:isar/isar.dart';

part 'create_code.g.dart';

/// Enumerator to hold qrcode categories
enum QRCodeCategory {Wifi, Text, Email, URL, Contact, Event, Image, File, Socials, SMS}
/// Enumerator to hold barcode categories
enum BarcodeCategory {QRCode, DataMatrix, PDF417, Aztec, EAN13, EAN8, EAN5, EAN2, UPC_E, UPC_A, Code128, Code93, Code39, Codabar, ITF, ISBN}

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

/// Model to be used to add created codes to isar db
class CreateCodeModel {
  String type;
  String codeName;
  String category;
  String codeData;
  String stringData;
  String datetime;

  CreateCodeModel({
    required this.type,
    required this.codeName,
    required this.category,
    required this.codeData,
    required this.stringData,
    required this.datetime,
  });
}

@Collection()
class CreateCode {
  Id id = Isar.autoIncrement;
  String? type;
  String? codeName;
  String? category;
  String? codeData;
  String? stringData;
  String? datetime;

  CreateCode({
    this.type,
    this.codeName,
    this.category,
    this.codeData,
    this.stringData,
    this.datetime,
  });
  
}