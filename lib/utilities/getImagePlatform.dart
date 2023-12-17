import 'dart:io';

import 'package:flutter/material.dart';

Image getImagePlatform(String path, BuildContext context, {BoxFit fit = BoxFit.cover, double? width}) {
  TargetPlatform platform = Theme.of(context).platform;
  if (platform == TargetPlatform.android || platform == TargetPlatform.iOS) {
    return Image.file(File(path), fit: fit, width: width);
  } else {
    return Image.network(path, fit: fit, width: width,);
  }
}
