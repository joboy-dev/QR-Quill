import 'package:isar/isar.dart';
part 'scan_code.g.dart';

class ScanCodeModel {
  String type;
  String codeName;
  String category;
  String codeData;
  String stringData;
  String datetime;

  ScanCodeModel({
    required this.type,
    required this.codeName,
    required this.category,
    required this.codeData,
    required this.stringData,
    required this.datetime,
  });
}

@Collection()
class ScanCode {
  Id id = Isar.autoIncrement;
  String? type;
  String? codeName;
  String? category;
  String? codeData;
  String? datetime;
  String? mediaPath;

  ScanCode({
    this.type,
    this.codeName,
    this.category,
    this.codeData,
    this.mediaPath,
    this.datetime,
  });
  
}