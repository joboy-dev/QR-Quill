import 'package:flutter/material.dart';
import 'package:qr_quill/models/create_code.dart';

class CreateCodeProvider extends ChangeNotifier {
  List<CreateCode> _createdCodes = [];

  List<CreateCode> get createdCodes => _createdCodes;

  void setCreatedCode(CreateCode code) {
    _createdCodes.add(code);
    notifyListeners();
  }

  void setCreatedCodes(List<CreateCode> codes) {
    _createdCodes = codes;
    notifyListeners();
  }

  void clearCreatedCodes() {
    _createdCodes = [];
    notifyListeners();
  }
}