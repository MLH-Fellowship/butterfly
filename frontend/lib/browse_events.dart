// Browse events screen
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'graphql_conf.dart';

class BrowseEvents extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Browse Events')),
        body: ListView(
          padding: EdgeInsets.all(16), //add padding to outside of the cards
          children: [buildEventCard()],
        ));
  }

  Widget buildEventCard() => Card(
      // make corners rounded
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),

      // add drop shadow
      shadowColor: Colors.grey.withOpacity(0.5),
      elevation: 5,
      child: Padding(
        padding: EdgeInsets.all(12), // add padding b/w text and card edges
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.start, //left-aligned
                children: [
              Text(
                'Event Name',
                style: TextStyle(fontSize: 32),
              ),
              const SizedBox(height: 12),
              Text('Description', style: TextStyle(fontSize: 24))
            ]),
      ));
}
