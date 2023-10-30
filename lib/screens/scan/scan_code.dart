// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_quill/shared/button.dart';
import 'package:qr_quill/shared/constants.dart';
import 'package:scan/scan.dart';

class ScanCode extends StatefulWidget {
  const ScanCode({super.key, required this.scanWithCameraNavTo, required this.scanFromImageNavTo});

  final Function() scanWithCameraNavTo;
  final Function() scanFromImageNavTo;

  @override
  State<ScanCode> createState() => _ScanCodeState();
}

class _ScanCodeState extends State<ScanCode> {
  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  String _platformVersion = 'Unknown';
  
  Future<void> initPlatformState() async {
    String platformVersion;
    try {
      platformVersion = await Scan.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: kAppPadding(),
              child: Column(
                children: [
                  Button(
                    buttonText: 'Scan with Camera', 
                    onPressed: widget.scanWithCameraNavTo,
                    buttonColor: kSecondaryColor, 
                    inactive: false,
                  ),
            
                  SizedBox(height: 20.h),
            
                  Button(
                    buttonText: 'Scan Image', 
                    onPressed: widget.scanFromImageNavTo, 
                    buttonColor: kTertiaryColor, 
                    inactive: false,
                  ),
            
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}