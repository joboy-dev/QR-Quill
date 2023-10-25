import 'package:flutter/material.dart';
import 'package:qr_quill/shared/constants.dart';

class ScanBarcode extends StatefulWidget {
  const ScanBarcode({super.key});

  static const String id = 'scan_barcode';

  @override
  State<ScanBarcode> createState() => _ScanBarcodeState();
}

class _ScanBarcodeState extends State<ScanBarcode> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: kAppPadding,
            child: const Column(
              children: [],
            ),
          ),
        ),
      ),
    );
  }
}