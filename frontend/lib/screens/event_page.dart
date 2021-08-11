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
      body: Container(
        padding: EdgeInsets.all(20.0),
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Palette.secondary_background,
          borderRadius: BorderRadius.circular(40.0)
        ),
        child: CustomScrollView(slivers: [
           SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, //left-aligned
              children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,//pushes icon to the end
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Event Name', 
                    style: TextStyle(fontSize: 28),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: const Icon(CupertinoIcons.ellipsis)
                  )
              ],)
            ],),
          )
        ],),
      ),
    );
  }
}