import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ImagePickerService {
  Future<File?> imagePick({required ImageSource source}) async {
    final _pick = ImagePicker();
    final pickedFile = await _pick.pickImage(source: source);
    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return null;
  }
}
