import 'package:flutter/material.dart';

class EventGoingTitle extends StatelessWidget {
  final String text;

  const EventGoingTitle({required Key key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontSize: 36, color: Colors.pink[700], fontWeight: FontWeight.bold),
    );
  }
}