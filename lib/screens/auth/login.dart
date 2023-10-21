import 'package:flutter/material.dart';
import 'package:qr_quill/shared/constants.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  static const String id = 'login';

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
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