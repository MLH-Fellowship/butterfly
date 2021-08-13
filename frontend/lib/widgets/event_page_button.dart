
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

import 'package:frontend/config/palette.dart';
import 'package:frontend/screens/display_events.dart';
import 'package:frontend/screens/dummy.dart';
import 'package:frontend/screens/event_button_mode.dart';
import 'package:frontend/screens/event_register.dart';
import 'package:frontend/screens/screen_type.dart';


class eventPageButton extends StatefulWidget {
  final EventButtonMode mode; // determines text and colour
  final ScreenType screen; // determines size
  const eventPageButton({ Key? key, required this.mode, required this.screen}) : super(key: key);

  @override
  _eventPageButtonState createState() => _eventPageButtonState();
}

class _eventPageButtonState extends State<eventPageButton> {
  @override
  Widget build(BuildContext context) {
  
    return Positioned(
      // alignment: Alignment.bottomCenter,
      bottom: 0.0,
      child: renderButton(widget.mode, widget.screen)
    );
  }

  Widget renderButton(mode, screen){
    // determine text and colour based on the mode
    Color buttonColor;
    String buttonText;
    if(mode == EventButtonMode.Delete){
      buttonColor = Colors.red;
      buttonText = 'Delete';
    }
    else if(mode == EventButtonMode.Cancel){
      buttonColor = Palette.highlight_2; // yellow
      buttonText = 'Cancel';
    }
    else{
      buttonColor = Palette.highlight_1; // green
      buttonText = 'Register';
    }

    // determine the size based on the page type
    double buttonFontSize;
    double buttonRadius;
    double buttonPadding;
    // if the screen is a display of event cards, then the button will be smaller
    if(screen == ScreenType.Browse || screen == ScreenType.Hosting || screen == ScreenType.Attending){
      buttonFontSize = 16.0;
      buttonRadius = 15.0;
      buttonPadding = 10.0;
    }
    // if the screen is an individual event page, then the button will be bigger
    else{
      buttonFontSize = 22.0;
      buttonRadius = 20.0;
      buttonPadding = 12.0;
    }

    return ElevatedButton(
        onPressed: _handleClick,
        child: Text(buttonText, style: TextStyle(fontSize: buttonFontSize, fontWeight: FontWeight.w500),), 
        style: ElevatedButton.styleFrom(
          primary: buttonColor, 
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(buttonRadius)),
          padding: EdgeInsets.all(buttonPadding),
          ),
    );
  }

  // determine the button action based on the button mode
  void _handleClick(){
    // register: take to the register form
    if(widget.mode == EventButtonMode.Register){
      Navigator.push(context, PageRouteBuilder(
        opaque: false,
        transitionDuration: Duration.zero,
        pageBuilder: (BuildContext context, _, __) {
          //return Center(child: Text('My PageRoute'));
                return EventRegister(screen: ScreenType.EventRegister);
          }
        )
      );
    }
    // delete: send a delete request, then send back to hosting page
    else if(widget.mode == EventButtonMode.Delete){
      // display a warning popup
      AwesomeDialog(
        context: context,
        dialogType: DialogType.WARNING,
        headerAnimationLoop: false,
        animType: AnimType.TOPSLIDE,
        showCloseIcon: true,
        closeIcon: Icon(Icons.close_fullscreen_outlined),
        title: 'Warning',
        desc:
            'Are you sure you want to delete this event?',
        btnCancelOnPress: () {},
        onDissmissCallback: (type) {
          debugPrint('Dialog Dissmiss from callback $type');
        },
        // if they confirm, then take them back to the hosting page and display a confirmation dialog
        btnOkOnPress: () {
          Navigator.push(context, PageRouteBuilder(
            opaque: false,
            transitionDuration: Duration.zero,
            pageBuilder: (BuildContext context, _, __) {
            return DisplayEvents(screen: ScreenType.Hosting, mode: widget.mode,);
              }
            )
          );
        }
      )
      ..show();        
    }
    // cancel: send a cancel request, then send back to attending page
    else if(widget.mode == EventButtonMode.Cancel){
      // display a confirmation popup
      AwesomeDialog(
        context: context,
        animType: AnimType.LEFTSLIDE,
        headerAnimationLoop: false,
        dialogType: DialogType.SUCCES,
        showCloseIcon: true,
        title: 'Success',
        desc:
            'Registration has been canceled',
        btnOkOnPress: () {
          // take user back to the attending page
          Navigator.push(context, PageRouteBuilder(
            opaque: false,
            transitionDuration: Duration.zero,
            pageBuilder: (BuildContext context, _, __) {
              //return Center(child: Text('My PageRoute'));
                    return DisplayEvents(screen: ScreenType.Attending, mode: widget.mode,);
              }
            )
          );
        },
        btnOkIcon: Icons.check_circle,
        onDissmissCallback: (type) {
          debugPrint('Dialog Dissmiss from callback $type');
        })
      ..show();
    }
  }

}
  
