import 'dart:io';

import 'package:flutter/material.dart';

Image getImagePlatform(String path, BuildContext context, {BoxFit fit = BoxFit.cover}) {
  TargetPlatform platform = Theme.of(context).platform;
  if (platform == TargetPlatform.android || platform == TargetPlatform.iOS) {
    return Image.file(File(path), fit: fit);
  } else {
    return Image.network(path, fit: fit,);
  }
}