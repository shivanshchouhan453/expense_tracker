// check if it image show only image
import 'package:flutter/material.dart';

bool isAssetPath(String icon) {
  return icon.contains('assets/');
}

// help to display icon or image
Widget buildIconWidget(String icon) {
  if (isAssetPath(icon)) {
    return Image.asset(icon, fit: BoxFit.contain);
  } else {
    return Text(icon, style: const TextStyle(fontSize: 24));
  }
}
