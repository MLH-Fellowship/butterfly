import 'package:flutter/material.dart';
import '../config/palette.dart';

PreferredSizeWidget CustomBar(String name, bool centeredTitle) {
  // Custom app bar
  return AppBar(
    centerTitle: centeredTitle, // left-align the text
    title: Text(name.toString(), 
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 28,
        color: Palette.primary_text
      ),       
    ),  
    toolbarHeight: 80.0,
    backgroundColor: Palette.primary_background,
    elevation: 0,
    automaticallyImplyLeading: false, // rm the back arrow
  );
}

