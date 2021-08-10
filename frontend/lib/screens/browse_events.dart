// Browse events screen
import 'dart:ui';
import 'dart:convert';
import 'package:flutter/material.dart';
import '../widgets/nav_drawer.dart';
import '../widgets/register_button.dart';

class BrowseEvents extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // render each event as a card
    return Scaffold(
        endDrawer: NavDrawer(),
        appBar: AppBar(title: const Text('Browse Events')),
        body: ListView(
          padding: EdgeInsets.fromLTRB(2, 5, 2, 5), //add padding to outside of the cards
          children: <Widget>[
            for(var i=0; i<3; i++) buildEventCard()
          ],
        ));
  }

  Widget buildEventCard() => Card(
      // make corners rounded
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),

      // add drop shadow
      shadowColor: Colors.grey.withOpacity(0.5),
      elevation: 5,
      margin: EdgeInsets.all(12),
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
      )
    );

    // card text in left col
    Widget buildCardLeft({required String eventName, required String location, required String time, required String description }) {
      print(eventName);
      return Column(
      crossAxisAlignment: CrossAxisAlignment.start, //left-aligned
      children: [
        Container(
          child: Text(eventName, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),)
        ),
        Container(
          padding: EdgeInsets.fromLTRB(0, 4, 0, 0),
          child: Text(location, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300, fontStyle: FontStyle.italic)
          )
        ),
        Container(
          padding: EdgeInsets.fromLTRB(0, 2, 0, 0),
          child: Text(time, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300, fontStyle: FontStyle.italic)
          )
        ),
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
        Container(
          child: Text(month, style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),)
        ),
        Container(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
          child: Text(day, style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)
          )
        ),
        RegisterButton()
      ]
    );
  }
  
}
