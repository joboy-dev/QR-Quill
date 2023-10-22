// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:qr_quill/screens/auth/login.dart';
import 'package:qr_quill/screens/get_started.dart';
import 'package:qr_quill/services/provider/pin_storage.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  static const String id = 'wrapper';

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  // variable to hold the pin value
  String? _pin;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // call function to load pin
      String? pin = await PinStorage().loadPin();
      setState(() {
        _pin = pin;
      });

    });
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return _pin != null ? const Login() : const GetStarted();
  }
}