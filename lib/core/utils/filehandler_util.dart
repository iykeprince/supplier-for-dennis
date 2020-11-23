import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;

class FileHandlerUtil {
  static Future<File> handlePickImage() async {
    final PickedFile pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      return File(pickedFile.path);
    } else {
      //operation was cancelled by user
      return null;
    }
  }

  static String getExtension(String filePath) {
    return p.extension(filePath);
  }
}
