// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/// Enumerator to hold qrcode categories
enum Category {Wifi, Text, Email, URL, Contact, Event, Image, File, Socials, SMS}

/// Map from Category enum to Icons
const categoryIcons = {
  Category.Wifi: Icons.wifi,
  Category.Text: Icons.text_snippet_rounded,
  Category.Email: Icons.email_rounded,
  Category.URL: Icons.link_rounded,
  Category.Contact: Icons.person_2_sharp,
  Category.Socials: FontAwesomeIcons.link,
  Category.Event: Icons.event,
  Category.Image: Icons.image,
  Category.File: Icons.file_present,
  Category.SMS: FontAwesomeIcons.commentSms,
};

/// Map from Category string data to Icons
Map<String, dynamic> categoryStringDataIcons = {
  Category.Wifi.name: Icons.wifi,
  Category.Text.name: Icons.text_snippet_rounded,
  Category.Email.name: Icons.email_rounded,
  Category.URL.name: Icons.link_rounded,
  Category.Contact.name: Icons.person_2_sharp,
  Category.Socials.name: FontAwesomeIcons.link,
  Category.Event.name: Icons.event,
  Category.Image.name: Icons.image,
  Category.File.name: Icons.file_present,
  Category.SMS.name: FontAwesomeIcons.commentSms,
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