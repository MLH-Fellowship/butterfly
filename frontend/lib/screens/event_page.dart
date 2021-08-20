import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/screens/event_button_mode.dart';
import 'package:frontend/screens/screen_type.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'map_month.dart';
import 'package:frontend/screens/dummy.dart';
import 'package:frontend/widgets/event_page_button.dart';


import '../config/palette.dart';

/// Displays an individual event page
/// 
/// Renders as an expanded card that slides up when an event card is clicked
/// Slides down to reveal the event cards when dismissed
class EventPage extends StatelessWidget {
  final String eventID; // determines which event to query for
  final EventButtonMode mode; // determines which button to display
  final ScreenType screen; // determines which type of screen to display
  const EventPage({ Key? key, required this.eventID, required this.mode, required this.screen }) : super(key: key);

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
        backgroundColor: Palette.primary_background,
        elevation: 0,
        leading: TextButton.icon(
          style: TextButton.styleFrom(primary: Palette.primary_text),
          onPressed: () => Navigator.of(context).pop(), // dismiss the screen
          icon: const Icon(CupertinoIcons.chevron_down), 
          label: Text('')
        ),
        
      ),
      /// Make a query to the database for a single event based on its ID
      body: Query(
        options: QueryOptions(
          documentNode: gql(getEventById),
          fetchPolicy: FetchPolicy.networkOnly,
        ),
        builder: (QueryResult? result,{VoidCallback? refetch, FetchMore? fetchMore}) {
          /// Handle exceptions and loading
          /// Necessary. Otherwise, an error will be thrown 
          /// while we wait for the database to return our requested data
          refetchQuery = refetch!;
          if (result!.hasException) {
            return Text(result.exception.toString());
          }
          if (result.loading) {
            return Text(''); // Just display a blank page when loading
          }

          final event = result!.data['event'];
          return Container(
            padding: EdgeInsets.all(45.0),
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Palette.secondary_background,
              borderRadius: BorderRadius.circular(40.0)
            ),
            child: Stack( /// We want the button to overlap/ "float over" the content
              alignment: Alignment.center,
              children: [
                ListView( /// Display as listview so we can scroll
                  children: [
                    renderContent(
                      event['name'],
                      event['location'],
                      mapMonth(event['date'].substring(5, 7)), // extract month, convert it to letters
                      event['date'].substring(8, 10), // extract day
                      event['startTime'],
                      event['endTime'],
                      event['description']
                    ),
                  ],
                ),
                eventPageButton(mode: mode, screen: screen, eventID: event['id'],)
              ],
            )
          );
        },
      ),
    );
  }

  // Renders the page as a whole
  Widget renderContent(String eventName, String location, String month, String day, String startTime, String endTime, String description, ){
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center, //left-aligned
        children: [
          // date
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
                Column(
                children: [
                  Text(month, style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal)),
                  Text(day, style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold))
                ]   
              )
            ],
          ),
          // title, location, time
          Column(
            children: [
              // title
              Container(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Text(eventName, style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold), textAlign: TextAlign.center,)),
              // location
              Container(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Text(location, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300, fontStyle: FontStyle.italic)),
              ),
              // time
              Container(
                padding: EdgeInsets.fromLTRB(0, 2, 0, 40),
                child: Text("${startTime} - ${endTime}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300, fontStyle: FontStyle.italic)
                )
              ),
            ],
          ),
          // description 
          renderSection('Description', description),
        ]
    );
  }
  
  /// Renders the page body
  Widget renderSection(String heading, String body){
    return Row(
      children: [
        Expanded( //wrap in expanded so the divider knows how much space to take up
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // heading
              Text(heading, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
              // divider
              const Divider(color: Palette.primary_text, height: 14,thickness: 1.5,),
              // body
              Text(body, style: TextStyle(fontSize: 15),)
            ],
          ),
        ),
      ],
    );             
  } // renderContent
}

