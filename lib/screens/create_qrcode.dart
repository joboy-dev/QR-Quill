import 'package:flutter/material.dart';
import 'package:qr_quill/shared/constants.dart';

class CreateQRCode extends StatefulWidget {
  const CreateQRCode({super.key});

  static const String id = 'create_qrrcode';

  @override
  State<CreateQRCode> createState() => _CreateQRCodeState();
}

class _CreateQRCodeState extends State<CreateQRCode> {
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