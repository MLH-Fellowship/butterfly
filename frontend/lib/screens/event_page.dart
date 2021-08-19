import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/screens/event_button_mode.dart';
import 'package:frontend/screens/screen_type.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'map_month.dart';
import 'package:frontend/screens/dummy.dart';
import 'package:frontend/widgets/event_page_button.dart';

import '../config/palette.dart';

class EventPage extends StatelessWidget {
  final String eventID;
  final EventButtonMode mode;
  final ScreenType screen;
  const EventPage(
      {Key? key,
      required this.eventID,
      required this.mode,
      required this.screen})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    VoidCallback refetchQuery;

    // pass eventID to the query
    final String getEventById = """
        query getEventById {
          event(eventId: "${eventID}") {
            name
            date
            startTime
            endTime  
            tag
            location
            description
          }
        }
      """;

    return Scaffold(
      appBar: AppBar(
        // leadingWidth: 145.0, //to avoid overflow error
        backgroundColor: Palette.primary_background,
        elevation: 0,
        leading: TextButton.icon(
            style: TextButton.styleFrom(primary: Palette.primary_text),
            onPressed: () => Navigator.of(context).pop(), //dismiss the screen
            icon: const Icon(CupertinoIcons.chevron_down),
            label: Text('')),
      ),
      body: Query(
        options: QueryOptions(
          // deprecated: documentNode: gql(getEventById),
          document: gql(getEventById),
          fetchPolicy: FetchPolicy.networkOnly,
        ),
        builder: (QueryResult? result,
            {VoidCallback? refetch, FetchMore? fetchMore}) {
          // handle exceptions and loading
          refetchQuery = refetch!;
          if (result!.hasException) {
            return Text(result.exception.toString());
          }
          // deprecated: if (result.loading) {
          if (result.isLoading) {
            return Text(''); //just display a blank page when loading
          }

          final event = result.data!['event'];
          return Container(
              padding: EdgeInsets.all(45.0),
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Palette.secondary_background,
                  borderRadius: BorderRadius.circular(40.0)),
              child: Stack(
                // we want the button to overlap/ "float over" the content
                alignment: Alignment.center,
                children: [
                  ListView(
                    //display as listview so we can scroll
                    children: [
                      renderContent(
                          event['name'],
                          event['location'],
                          mapMonth(event['date'].substring(5, 7)), // month
                          event['date'].substring(8, 10), // day
                          event['date'],
                          event['description']),
                    ],
                  ),
                  eventPageButton(mode: mode, screen: screen)
                ],
              ));
        },
      ),
    );
  }

  Widget renderContent(
    String eventName,
    String location,
    String month,
    String day,
    String time,
    String description,
  ) {
    return Column(crossAxisAlignment: CrossAxisAlignment.center, //left-aligned
        children: [
          // date
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Column(children: [
                Text(month,
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.normal)),
                Text(day,
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold))
              ])
            ],
          ),
          // title, location, time
          Column(
            children: [
              // title
              Container(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Text(
                    eventName,
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  )),
              // location
              Container(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Text(location,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        fontStyle: FontStyle.italic)),
              ),
              // time
              Container(
                  padding: EdgeInsets.fromLTRB(0, 2, 0, 40),
                  child: Text(time,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                          fontStyle: FontStyle.italic))),
            ],
          ),
          // description
          renderSection('Description', description),
          SizedBox(
            height: 50,
          ), // add spacing b/w sections
          renderSection('Attendees', 'TBD'),
          SizedBox(
            height: 50,
          ),
          renderSection('Discussion', 'TBD '),
        ]);
  }

  Widget renderSection(String heading, String body) {
    return Row(
      children: [
        Expanded(
          //wrap in expanded so the divider knows how much space to take
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // heading
              Text(
                heading,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              // divider
              const Divider(
                color: Palette.primary_text,
                height: 14,
                thickness: 1.5,
              ),
              // body
              Text(
                body,
                style: TextStyle(fontSize: 15),
              )
            ],
          ),
        ),
      ],
    );
  } // renderContent
}
