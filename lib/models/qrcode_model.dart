// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// create enumerator to hold qrcode categories
enum Category {Wifi, Text, Email, URL, Contact, Event, Image, File, Socials, SMS}

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

// ALL CODE MODELS
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