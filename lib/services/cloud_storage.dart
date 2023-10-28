import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qr_quill/shared/logger.dart';

/// For storing images and files.
class CloudStorage{
  final storageRef = FirebaseStorage.instance.ref();

  /// Function to upload image to storage
  uploadImage(XFile? file)  async{
    final imageDir = storageRef.child('images');

    // generate file name for the file to be stored in firebase storage
    String fileName = 'QRQuill_image_${DateTime.now().millisecondsSinceEpoch}.png';

    final imageFile = imageDir.child(fileName);

    try {
      await imageFile.putFile(File(file!.path));

      // get download link
      final imageUrl = await imageFile.getDownloadURL();

      return imageUrl;
    } catch (e) {
      logger(e.toString());
    }
  }

  /// Function to upload file to storage
  uploadFile(FilePickerResult? pickedFile) async {
    final fileDir = storageRef.child('files');

    String fileName = '${DateTime.now().millisecondsSinceEpoch}_${pickedFile!.files.single.path!.split('/').last}';

    final file = fileDir.child(fileName);

    try {
      await file.putFile(File(pickedFile.files.single.path!));

      // get file download link
      final fileUrl = await file.getDownloadURL();

      return fileUrl;
    } catch (e) {
      logger(e.toString());
    }

  }
}