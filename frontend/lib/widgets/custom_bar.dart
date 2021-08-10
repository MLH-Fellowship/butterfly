import 'package:flutter/material.dart';
import '../config/palette.dart';
import '../screens/screen_type.dart';

PreferredSizeWidget CustomBar(ScreenType screen, bool centeredTitle) {
  // Custom app bar
  return AppBar(
    centerTitle: centeredTitle, // left-align the text
    title: Text(display_title(screen), 
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

// determines which title to display, based on the screen type
String display_title(ScreenType screen){
  if(screen == ScreenType.Butterfly){
    return 'Butterfly';
  }
  else if(screen == ScreenType.Browse){
    return 'Browse Events';
  }
  else if(screen == ScreenType.Hosting){
    return 'Events you\'re hosting';
  }
  else if(screen == ScreenType.Attending){
    return 'Events you\'re attending';
  }
  else if(screen == ScreenType.EventPg){
    return 'Event';
  }
  else return '';
}