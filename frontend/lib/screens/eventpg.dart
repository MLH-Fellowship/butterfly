/// Flutter code sample for Card

// This sample shows creation of a [Card] widget that shows album information
// and two actions.
import 'dart:ui';
import 'package:flutter/material.dart';
import '../widgets/nav_drawer.dart';
import '../widgets/register_button.dart';

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
          time: 'time',
          location: 'location',
          description: 'description',
          attendee: 'Martha',
          discussion: 'hello',
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
    required this.time,
    required this.location,
    required this.description,
    required this.attendee,
    required this.discussion,
  }) : super(key: key);

  final String eventName;
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
              Text(
                time,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.black45,
                ),
              ),
              Text(
                location,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.black45,
                ),
              ),
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
                location,
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.black87,
                ),
              ),
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
              RegisterButton(),
            ],
          ),
        ),
      ],
    );
  }
}
