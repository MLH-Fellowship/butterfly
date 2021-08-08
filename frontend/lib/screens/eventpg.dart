import 'package:flutter/material.dart';
import 'package:frontend/models/eventgoing.dart';
import '../widgets/nav_drawer.dart';
import '../shared/heart.dart';
//import '../widgets/register_button.dart';

/// This is the main application widget.
class EventPg extends StatelessWidget {
  //const EventPg({Key? key}) : super(key: key);

  final EventGoing eventgoing;
  EventPg({required this.eventgoing});

  //static const String _title = 'Event Page';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        //title: _title,
        home: Scaffold(
            endDrawer: NavDrawer(),
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            extendBodyBehindAppBar: true,
            body: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  ClipRRect(
                      child: Image.asset(
                    'images/${eventgoing.img}',
                    height: 360,
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                  )),
                  SizedBox(height: 30),
                  ListTile(
                      title: Text(eventgoing.eventName,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.grey[800])),
                      subtitle: Text(
                          '${eventgoing.date} \n ${eventgoing.time} \n\$${eventgoing.location}',
                          style: TextStyle(letterSpacing: 1)),
                      trailing: Heart()),
                  Padding(
                      padding: EdgeInsets.all(18),
                      child: Text("description paragraph",
                          style:
                              TextStyle(color: Colors.grey[600], height: 1.4))),
                ],
              ),
            )));
  }
}
