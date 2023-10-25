import 'package:flutter/material.dart';
import 'package:qr_quill/shared/constants.dart';

class CreateBarcode extends StatefulWidget {
  const CreateBarcode({super.key});

  static const String id = 'create_barcode';

  @override
  State<CreateBarcode> createState() => _CreateBarcodeState();
}

class _CreateBarcodeState extends State<CreateBarcode> {
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