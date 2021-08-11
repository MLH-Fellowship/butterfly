import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/screens/dummy.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'map_month.dart';


import '../config/palette.dart';

class EventPage extends StatelessWidget {
  final String eventID;
  const EventPage({ Key? key, required this.eventID }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // pass eventID to the query
    final String getEventById = """
        query getEventById {
          event(eventId: "${eventID}") {
            name
            date  
            tag
            organizer
            location
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
          label: Text('')
        ),
        // title: Text('Browse Events'),
        // centerTitle: false,
      ),
      body: Query(
        options: QueryOptions(
          documentNode: gql(getEventById),
          fetchPolicy: FetchPolicy.networkOnly,
        ),
        builder: (QueryResult? result,
            {VoidCallback? refetch, FetchMore? fetchMore}) {
          final event = result!.data['event'];
          return Container(
            padding: EdgeInsets.all(45.0),
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Palette.secondary_background,
              borderRadius: BorderRadius.circular(40.0)
            ),
            child: Stack( // we want the button to overlap/ "float over" the content
              alignment: Alignment.center,
              children: [
                ListView( //display as listview so we can scroll
                  children: [
                    renderContent(
                      event['name'],
                      event['location'],
                      mapMonth(event['date'].substring(5, 7)), // month
                      event['date'].substring(8, 10), // day
                      event['date'],
                      'Team meeting to brief each other on our progress and decide next steps. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'
                    ),
                  ],
                ),
                eventPageButton(mode: 'Register')
              ],
            )
          );
        },
      ),
    );
  }

  Widget renderContent(String eventName, String location, String month, String day, String time, String description, ){
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
                child: Text(time, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300, fontStyle: FontStyle.italic)
                )
              ),
            ],
          ),
          // description 
          renderSection('Description', description),
          SizedBox(height: 50,), // add spacing b/w sections
          renderSection('Attendees', 'TBD'),
          SizedBox(height: 50,),
          renderSection('Discussion', 'TBD '),
        ]
    );
  }
  
  Widget renderSection(String heading, String body){
    return Row(
            children: [
              Expanded( //wrap in expanded so the divider knows how much space to take
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // heading
                    Text(heading, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600), overflow: TextOverflow.ellipsis),
                    const Divider(
                      color: Palette.primary_text,
                      height: 14,
                      thickness: 1.5,
                    ),
                    // body
                    Text(body, style: TextStyle(fontSize: 15),)
                  ],
                ),
              ),
            ],
          );             
  } // renderContent
}

class eventPageButton extends StatefulWidget {
  final String mode;
  const eventPageButton({ Key? key, required this.mode, }) : super(key: key);

  @override
  _eventPageButtonState createState() => _eventPageButtonState();
}

class _eventPageButtonState extends State<eventPageButton> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      // alignment: Alignment.bottomCenter,
      bottom: 0.0,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(context, PageRouteBuilder(
            opaque: false,
            transitionDuration: Duration.zero,
            pageBuilder: (BuildContext context, _, __) {
              //return Center(child: Text('My PageRoute'));
                    return DummyPage();
              }
            )
          );
        }, 
        child: Text(widget.mode, style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),), 
        style: ElevatedButton.styleFrom(
          primary: Palette.highlight_1, 
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          padding: EdgeInsets.all(12.0),
          ),
      )
    );
  }
}