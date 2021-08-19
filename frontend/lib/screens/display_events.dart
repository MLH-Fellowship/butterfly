import 'dart:ui';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/config/palette.dart';
import 'package:frontend/screens/determine_query.dart';
import 'package:frontend/screens/event_button_mode.dart';
import 'package:frontend/widgets/event_page_button.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'package:frontend/screens/event_page.dart';
import '../widgets/custom_bar.dart';
import '../widgets/nav_drawer.dart';
import '../widgets/register_button.dart';
import '../widgets/bottom_nav.dart';
import 'browse_events.dart';
import 'eventpg.dart';
import 'screen_type.dart';
import 'event_page.dart';
import 'map_month.dart';

class DisplayEvents extends StatefulWidget {
  // takes a paramter to customize the page name
  final ScreenType screen;
  final EventButtonMode mode;
  const DisplayEvents({Key? key, required this.screen, required this.mode})
      : super(key: key);

  @override
  _DisplayEventsState createState() => _DisplayEventsState();
}

class _DisplayEventsState extends State<DisplayEvents> {
  @override
  Widget build(BuildContext context) {
    VoidCallback refetchQuery;

    // Based on param, determine type of request to make to the backend
    final String getAllEvents = determineQuery(widget.screen);

    // render each event as a card
    return Scaffold(
      // endDrawer: NavDrawer(),
      appBar: CustomBar(widget.screen, false), //display a custom title
      body: ListView(
        padding: EdgeInsets.fromLTRB(
            2, 5, 2, 5), //add padding to outside of the cards
        children: <Widget>[
          Query(
            options: QueryOptions(
              // deprecated: documentNode: gql(getAllEvents),
              document: gql(getAllEvents),

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
              final events = result.data!['allEvents'];

              return ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: events.length,
                itemBuilder: (BuildContext context, int index) {
                  final event = events[index];
                  return buildEventCard(event);
                },
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomNav(
        screen: widget.screen,
      ),
    );
  }

  //TODO: Based on param, determine type of request to make to the backend

  Widget buildEventCard(event) => Card(
      // make corners rounded
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      // add drop shadow
      shadowColor: Colors.grey.withOpacity(0.5),
      color: Palette.secondary_background,
      elevation: 5,
      margin: EdgeInsets.all(12),
      child: InkWell(
          // wrap in gesture detector to make card clickable
          onTap: () {
            // We don't pop, bc we want to return to this pg when we dismiss the event page
            Navigator.of(context).push(MaterialPageRoute(
                fullscreenDialog: true,
                builder: (context) => EventPage(
                      eventID: event['id'],
                      mode: widget.mode,
                      screen: ScreenType.EventPage,
                    )));
          },
          borderRadius: BorderRadius.all(Radius.circular(50)),
          child: FittedBox(
            fit: BoxFit.contain,
            child: Container(
                padding: EdgeInsets.all(18),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildCardLeft(
                        eventName: event['name'],
                        location: event['location'],
                        time: event['date'],
                        description: event['description']),
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                      child: buildCardRight(
                        month: mapMonth(event['date'].substring(5, 7)),
                        day: event['date'].substring(8, 10),
                      ),
                    )
                  ],
                )),
          )));

  // card text in left col
  Widget buildCardLeft(
      {required String eventName,
      required String location,
      required String time,
      required String description}) {
    print(eventName);
    return Column(crossAxisAlignment: CrossAxisAlignment.start, //left-aligned
        children: [
          // event name
          Container(
              width: 275,
              child: Text(eventName,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis)),
          // location
          Container(
              padding: EdgeInsets.fromLTRB(0, 4, 0, 0),
              child: Text(location,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      fontStyle: FontStyle.italic))),
          // time
          Container(
              padding: EdgeInsets.fromLTRB(0, 2, 0, 0),
              child: Text(time,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      fontStyle: FontStyle.italic))),
          // description
          Container(
              padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
              width: 275,
              child: Text(description,
                  style: TextStyle(fontSize: 16),
                  overflow: TextOverflow.ellipsis))
        ]);
  }

  // date and registration button in card's right col
  Widget buildCardRight({required String month, required String day}) {
    return Column(crossAxisAlignment: CrossAxisAlignment.center, //left-aligned
        children: [
          Container(
              child: Text(
            month,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
          )),
          Container(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: Text(day,
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold))),
          // RegisterButton()
          eventPageButton(mode: widget.mode, screen: widget.screen)
        ]);
  }
}
