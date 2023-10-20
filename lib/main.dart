import 'package:flutter/material.dart';

void main() {
  runApp(const QRQuill());
}

class QRQuill extends StatelessWidget {
  const QRQuill({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QR Quill',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}
