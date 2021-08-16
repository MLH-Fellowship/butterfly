
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

import 'package:frontend/config/palette.dart';
import 'package:frontend/screens/display_events.dart';
import 'package:frontend/screens/dummy.dart';
import 'package:frontend/screens/event_button_mode.dart';
import 'package:frontend/screens/event_register.dart';
import 'package:frontend/screens/screen_type.dart';
import 'package:graphql_flutter/graphql_flutter.dart';


class eventPageButton extends StatefulWidget {
  final EventButtonMode mode; // determines text and colour
  final ScreenType screen; // determines size
  final String eventID;
  const eventPageButton({ Key? key, required this.mode, required this.screen, required this.eventID}) : super(key: key);

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

    // determine text, colour, and function based on the mode
    Color buttonColor;
    String buttonText;

    if(mode == EventButtonMode.Delete){
      buttonColor = Colors.red;
      buttonText = 'Delete';
      return deleteButton(buttonColor, buttonText, buttonFontSize, buttonRadius, buttonPadding);
    }
    else if(mode == EventButtonMode.Cancel){
      buttonColor = Palette.highlight_2; // yellow
      buttonText = 'Cancel';
      return cancelButton(buttonColor, buttonText, buttonFontSize, buttonRadius, buttonPadding);
    }
    else{
      buttonColor = Palette.highlight_1; // green
      buttonText = 'Register';
      return registerButton(buttonColor, buttonText, buttonFontSize, buttonRadius, buttonPadding);
    }
  }

  Widget deleteButton(Color buttonColor, String buttonText, double buttonFontSize, double buttonRadius, double buttonPadding){
    final String deleteEvent = """
      mutation deleteEvent(\$eventId: ID!) {
        deleteEvent(eventId: \$eventId) {
          deleted
        }
      }
      """;

      // Make a delete event mutation
      return Mutation(
      options: MutationOptions(
        documentNode: gql(deleteEvent),
        onCompleted: (dynamic resultData){
          if(resultData?.isEmpty ?? true){
            print("null data");
          }
          else{
            var data = resultData.data["deleteEvent"];
            print("mutation added: ${data}");
          }
        },
        onError: (err) {
          print(err.graphqlErrors);
        },
      ), 
      builder: (RunMutation runMutation, QueryResult result){
        // next & submit button
        return ElevatedButton(
          onPressed: () {
              runMutation({
                  "eventId": widget.eventID,
              });
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
                // if they confirm, then take them back to the hosting page 
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
            },
            
        child: Text(buttonText, style: TextStyle(fontSize: buttonFontSize, fontWeight: FontWeight.w500),), 
        style: ElevatedButton.styleFrom(
          primary: buttonColor, 
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(buttonRadius)),
          padding: EdgeInsets.all(buttonPadding),
          ),
        );
      },
    );
  } // deleteButton

  Widget cancelButton(Color buttonColor, String buttonText, double buttonFontSize, double buttonRadius, double buttonPadding){
    // send a cancellation mutation
    final String cancelRegistration = """
      mutation deleteAttendees(\$eventId: ID!, \$userId: ID!) {
        deleteAttendees(eventId: \$eventId, userId: \$userId) {
          event {
            id
            name
            attendees {
              id
              name
            }
          }
        }
      }
      """;

    return Mutation(
      options: MutationOptions(
        documentNode: gql(cancelRegistration),
        onCompleted: (dynamic resultData){
          if(resultData?.isEmpty ?? true){
            print('null data');
          }
          else{
            var data = resultData.data["deleteAttendees"];

            print("mutation added: ${data}");
          }
        },
        onError: (err) {
          print(err.graphqlErrors);
        },
      ), 
      builder: (RunMutation runMutation, QueryResult result){
        // next & submit button
        return ElevatedButton(
          onPressed: () {
              runMutation({
                  "eventId": widget.eventID,
                  "userId": "1",
              });
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
            },
            
        child: Text(buttonText, style: TextStyle(fontSize: buttonFontSize, fontWeight: FontWeight.w500),), 
        style: ElevatedButton.styleFrom(
          primary: buttonColor, 
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(buttonRadius)),
          padding: EdgeInsets.all(buttonPadding),
          ),
        );
      },
    );
  } // cancelButton
  
  Widget registerButton(Color buttonColor, String buttonText, double buttonFontSize, double buttonRadius, double buttonPadding){
    return ElevatedButton(
      onPressed: () {
        // take to the event registration form
        Navigator.push(context, PageRouteBuilder(
          opaque: false,
          transitionDuration: Duration.zero,
          pageBuilder: (BuildContext context, _, __) {
              return EventRegister(screen: ScreenType.EventRegister, eventID: widget.eventID,);
            }
          )
        );
      },
      child: Text(buttonText, style: TextStyle(fontSize: buttonFontSize, fontWeight: FontWeight.w500),), 
      style: ElevatedButton.styleFrom(
        primary: buttonColor, 
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(buttonRadius)),
        padding: EdgeInsets.all(buttonPadding),
        ),
    );
  } // registerButton
}