// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// create enumerator to hold qrcode categories
enum Category {Wifi, Text, Email, URL, Location, Contact, Event, Image, PDF, File, Socials}

const categoryIcons = {
  Category.Wifi: Icons.wifi,
  Category.Text: Icons.text_snippet_rounded,
  Category.Email: Icons.email_rounded,
  Category.URL: Icons.link_rounded,
  Category.Location: Icons.place,
  Category.Contact: Icons.person_2_sharp,
  Category.Socials: FontAwesomeIcons.link,
  Category.Event: Icons.event,
  Category.Image: Icons.image,
  Category.PDF: FontAwesomeIcons.solidFilePdf,
  Category.File: FontAwesomeIcons.file,
};

// ALL CODE MODELS
class QRCode {
  
}