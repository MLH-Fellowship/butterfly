// Browse events screen
import 'dart:ui';

import 'package:flutter/material.dart';
import 'nav_drawer.dart';


class BrowseEvents extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        endDrawer: NavDrawer(),
        appBar: AppBar(title: const Text('Browse Events')),
        body: ListView(
          padding: EdgeInsets.fromLTRB(2, 5, 2, 5), //add padding to outside of the cards
          children: [
            buildEventCard(),
            buildEventCard(),
            buildEventCard(),
            buildEventCard(),
            buildEventCard(),
            buildEventCard(),
            buildEventCard(),
            buildEventCard()
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
          cardLeft,
          Container(
            padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
            child: cardRight,
          )
        ],)
      )
    );

    // card text in left col
    final cardLeft = Column(
      crossAxisAlignment: CrossAxisAlignment.start, //left-aligned
      children: [
        Container(
          child: const Text('Martha\'s Birthday Bash', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),)
        ),
        Container(
          padding: EdgeInsets.fromLTRB(0, 4, 0, 0),
          child: const Text('1234 W Sample St, Vancouver, BC', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300, fontStyle: FontStyle.italic)
          )
        ),
        Container(
          padding: EdgeInsets.fromLTRB(0, 2, 0, 0),
          child: const Text('6:00pm - 11:00pm', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300, fontStyle: FontStyle.italic)
          )
        ),
        Container(
          padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
          child: const Text('Celebrating Martha\'s 75th birthday', style: TextStyle(fontSize: 15), overflow: TextOverflow.ellipsis)
        )
      ]
    );

    // date and registration button in card's right col
    final cardRight = Column(
      crossAxisAlignment: CrossAxisAlignment.center, //left-aligned
      children: [
        Container(
          child: const Text('NOV', style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),)
        ),
        Container(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
          child: const Text('4', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)
          )
        ),
        ElevatedButton(
          onPressed: null, 
          // style: ButtonStyle(padding: EdgeInsets.all(0.0), ),
          child: const Text('Register', style: TextStyle(fontSize: 11)) )
      ]
    );
  
    // void _registerPressed() {
    //   Navigator.push(context, MaterialPageRoute(builder: (context) => BrowseEvents()));
    // }
}
