import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

/// Defines the colours used for the app's design scheme
class Palette {
  static const Color primary_background = Color(0xFFFAEEE7); // need to prefix hex codes with '0xFF'
  static const Color secondary_background = Color(0xFFFFFDF8);
  static const Color highlight_1 = Color(0xFF005B47);
  static const Color highlight_2 = Color(0xFFFAAE2B);
  static const Color primary_text = Color(0xFF352C27);

  //for login
  static const TextStyle kBodyText =
      TextStyle(fontSize: 22, color: Color(0xFF005B47), height: 1.5);
}
