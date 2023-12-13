import 'dart:io';

import 'package:flutter/material.dart';

Image getImagePlatform(String path, BuildContext context) {
  TargetPlatform platform = Theme.of(context).platform;
  if (platform == TargetPlatform.android || platform == TargetPlatform.iOS) {
    return Image.file(File(path));
  } else {
    return Image.network(path);
  }
}