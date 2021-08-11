import 'dart:ui';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/config/palette.dart';
import 'package:frontend/screens/event_page.dart';
import '../widgets/custom_bar.dart';
import '../widgets/nav_drawer.dart';
import '../widgets/register_button.dart';
import '../widgets/bottom_nav.dart';
import 'eventpg.dart';
import 'screen_type.dart';
import 'event_page.dart';



class DisplayEvents extends StatefulWidget {
  // takes a paramter to customize the page name
  // final String pageName;
  final ScreenType screen;
  const DisplayEvents({ Key? key, required this.screen }) : super(key: key);

  @override
  _DisplayEventsState createState() => _DisplayEventsState();
}

class _DisplayEventsState extends State<DisplayEvents> {
  @override
  Widget build(BuildContext context) {
    // render each event as a card
    return Scaffold(
        // endDrawer: NavDrawer(),
        appBar: CustomBar(widget.screen, false), //display a custom title
        body: ListView(
          padding: EdgeInsets.fromLTRB(2, 5, 2, 5), //add padding to outside of the cards
          children: <Widget>[
            for(var i=0; i<3; i++) buildEventCard()
          ],
        ),
        bottomNavigationBar: BottomNav(screen: widget.screen,),
      );
  }
  
  //TODO: Based on param, determine type of request to make to the backend

  Widget buildEventCard() => Card(
      // make corners rounded
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      // add drop shadow
      shadowColor: Colors.grey.withOpacity(0.5),
      color: Palette.secondary_background,
      elevation: 5,
      margin: EdgeInsets.all(12),
      child: InkWell( // wrap in gesture detector to make card clickable
        onTap: _cardTapped,
        borderRadius: BorderRadius.all(Radius.circular(50)),
        child: FittedBox(
          fit: BoxFit.contain,
          child: Container(
            padding: EdgeInsets.all(18),
            child: Row( 
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildCardLeft(
                eventName: 'Martha\'s Birthday Bash',
                location: '1234 W Sample St, Vancouver, BC',
                time: '6:00pm - 11:00pm',
                description: 'Celebrating Martha\'s 75th birthday'
              ),
              Container(
                padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: buildCardRight(
                  month: 'NOV',
                  day: '4'
                ),
              )
            ],)
      ),
        )
      
    )
  );
    
  

    // card text in left col
    Widget buildCardLeft({required String eventName, required String location, required String time, required String description }) {
      print(eventName);
      return Column(
      crossAxisAlignment: CrossAxisAlignment.start, //left-aligned
      children: [
        // event name
        Container(
          child: Text(eventName, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis)
        ),
        // location
        Container(
          padding: EdgeInsets.fromLTRB(0, 4, 0, 0),
          child: Text(location, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300, fontStyle: FontStyle.italic)
          )
        ),
        // time
        Container(
          padding: EdgeInsets.fromLTRB(0, 2, 0, 0),
          child: Text(time, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300, fontStyle: FontStyle.italic)
          )
        ),
        // description
        Container(
          padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
          child: Text(description, style: TextStyle(fontSize: 15), overflow: TextOverflow.ellipsis)
        )
      ]
    );
  }

    // date and registration button in card's right col
    Widget buildCardRight({required String month, required String day}){
      return Column(
      crossAxisAlignment: CrossAxisAlignment.center, //left-aligned
      children: [
        //month
        Container(
          child: Text(month, style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),)
        ),
        // day
        Container(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
          child: Text(day, style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)
          )
        ),
        RegisterButton()
      ]
    );
  }

  void _cardTapped(){
    print('card tapped');
    // We don't pop, bc we want to return to this pg when we dismiss the event page
    Navigator.of(context).push(MaterialPageRoute(
      fullscreenDialog: true,
      builder: (context) => EventPage(eventID: 1)));
  }
}