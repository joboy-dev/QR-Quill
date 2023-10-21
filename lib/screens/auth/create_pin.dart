import 'package:flutter/material.dart';
import 'package:qr_quill/shared/constants.dart';

class CreatePin extends StatefulWidget {
  const CreatePin({super.key});

  static const String id = 'create_oin';

  @override
  State<CreatePin> createState() => _CreatePinState();
}

class _CreatePinState extends State<CreatePin> {
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