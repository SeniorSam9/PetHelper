
import 'dart:convert';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';

Future<String> encodeImage(XFile imageFile) async {
  Uint8List imageBytes = await imageFile.readAsBytes();
  String base64Image = base64Encode(imageBytes);
  return base64Image;
}

XFile decodeImage(String base64Image) {
  Uint8List imageBytes = base64Decode(base64Image);
  return XFile.fromData(imageBytes);
}