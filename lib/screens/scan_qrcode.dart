import 'package:flutter/material.dart';
import 'package:qr_quill/shared/constants.dart';

class ScanQRCode extends StatefulWidget {
  const ScanQRCode({super.key});

  static const String id = 'scan_qrrcode';

  @override
  State<ScanQRCode> createState() => _ScanQRCodeState();
}

class _ScanQRCodeState extends State<ScanQRCode> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: kAppPadding,
            child: Column(
              children: [],
            ),
          ),
        ),
      ),
    );
  }
}