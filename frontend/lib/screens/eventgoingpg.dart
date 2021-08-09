import 'package:flutter/material.dart';
import '../shared/eventgoingtitle.dart';
import '../shared/eventgoinglist.dart';

class EventGoingPg extends StatefulWidget {
  @override
  _EventGoingPg createState() => _EventGoingPg();
}

class _EventGoingPg extends State<EventGoingPg> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("../images/i1.png"),
                  fit: BoxFit.fitWidth,
                  alignment: Alignment.topLeft),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 30),
                SizedBox(
                  height: 160,
                  child: EventGoingTitle(
                      key: UniqueKey(), text: 'Events You\'re Going'),
                ),
                Flexible(
                  child: EventGoingList(),
                )
                //Sandbox(),
              ],
            )));
  }
}
