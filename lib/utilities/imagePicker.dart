

import 'package:image_picker/image_picker.dart';

final picker = ImagePicker();
Future<XFile?> pickImages() async {
  return await picker.pickImage(source: ImageSource.gallery);
}