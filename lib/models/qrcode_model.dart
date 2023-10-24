// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// create enumerator to hold qrcode categories
enum Category {Wifi, Text, Email, URL, Location, Contact, Event, Image, File, Socials}

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
  Category.File: FontAwesomeIcons.file,
};

// ALL CODE MODELS
class QRCodeModel {
  String type;
  String qrTitle;
  String category;

  // Wifi
  String? wifiName;
  String? widiPassword;

  // Email
  String? email;

  // Text
  String? text;

  // URL
  String? url;

  // Contact
  String? fullName;
  String? phoneNumber;
  String? address;
  // email already present

  // Event
  String? eventTitle;
  String? eventLocation;
  String? startDate;
  String? startTime;
  String? endDate;
  String? endTime;

  // Location

  // Image
  String? imagePath;

  // File
  String? filePath;

  QRCodeModel({
    required this.type,
    required this.qrTitle,
    required this.category,
    this.wifiName,
    this.widiPassword,
    this.email,
    this.text,
    this.url,
    this.fullName,
    this.phoneNumber,
    this.address,
    this.eventTitle,
    this.eventLocation,
    this.startDate,
    this.startTime,
    this.endDate,
    this.endTime,
    this.imagePath,
    this.filePath,
  });
}