import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../config/palette.dart';

class EventPage extends StatelessWidget {
  final int eventID;
  const EventPage({ Key? key, required this.eventID }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        // leadingWidth: 145.0, //to avoid overflow error
        backgroundColor: Palette.primary_background,
        elevation: 0,
        leading: TextButton.icon(
          style: TextButton.styleFrom(primary: Palette.primary_text),
          onPressed: () => Navigator.of(context).pop(), //dismiss the screen
          icon: const Icon(CupertinoIcons.chevron_down), 
          label: Text('')
        ),
        // title: Text('Browse Events'),
        // centerTitle: false,
      ),
    );
  }
}