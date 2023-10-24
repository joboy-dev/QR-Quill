import 'package:path_provider/path_provider.dart';

Future<String> getAppDirctory() async {
  final appDir = await getApplicationDocumentsDirectory();
  return appDir.path;
}