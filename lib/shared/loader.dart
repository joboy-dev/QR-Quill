import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:qr_quill/shared/constants.dart';

class Loader extends StatelessWidget {
  const Loader({super.key, this.size, this.color});

  final double? size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SpinKitPianoWave(
      color: color ?? kSecondaryColor,
      size: size ?? 30.0,
    );
  }
}
