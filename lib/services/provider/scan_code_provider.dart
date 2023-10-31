import 'package:flutter/material.dart';
import 'package:qr_quill/models/scan_code.dart';

class ScanCodeProvider extends ChangeNotifier {
  List<ScanCode> _scannedCodes = [];

  List<ScanCode> get scannedCodes => _scannedCodes;

  void setScannedCode(ScanCode code) {
    _scannedCodes.add(code);
    notifyListeners();
  }

  void setScannedCodes(List<ScanCode> codes) {
    _scannedCodes = codes;
    notifyListeners();
  }

  void clearScannedCodes() {
    _scannedCodes = [];
    notifyListeners();
  }
}