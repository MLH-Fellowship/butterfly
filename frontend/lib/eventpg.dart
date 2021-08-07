/// Flutter code sample for Card

// This sample shows creation of a [Card] widget that shows album information
// and two actions.
//import 'dart:ui';
import 'package:flutter/material.dart';
import '../nav_drawer.dart';
import '../register_button.dart';

/// This is the main application widget.
class EventPg extends StatelessWidget {
  const EventPg({Key? key}) : super(key: key);

  static const String _title = 'Event Page';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        endDrawer: NavDrawer(),
        appBar: AppBar(title: const Text(_title)),
        body: const _EventInfo(
          eventName: 'My event',
          date: 'date',
          time: 'time',
          location: 'location',
          description: 'description',
          attendee: 'attendee',
          discussion: 'discussion',
        ),
      ),
    );
  }
}

/// This is the stateless widget that the main application instantiates.
class _EventInfo extends StatelessWidget {
  const _EventInfo({
    Key? key,
    required this.eventName,
    required this.date,
    required this.time,
    required this.location,
    required this.description,
    required this.attendee,
    required this.discussion,
  }) : super(key: key);

  final String eventName;
  final String date;
  final String time;
  final String location;
  final String description;
  final String attendee;
  final String discussion;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                eventName,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                ),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 2.0)),
              Spacer(flex: 2),
              Text(
                date,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.black45,
                ),
              ),
              Spacer(),
              Text(
                time,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.black45,
                ),
              ),
              Spacer(flex: 2),
              Text(
                location,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.black45,
                ),
              ),
              Spacer(flex: 3),
              const Padding(padding: EdgeInsets.only(bottom: 2.0)),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                attendee,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 2.0)),
              Spacer(flex: 1),
              Text(
                description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.black,
                ),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 2.0)),
              Spacer(flex: 2),
              Text(
                discussion,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 2.0)),
              Spacer(),
              RegisterButton(),
            ],
          ),
        ),
      ],
    );
  }
}
