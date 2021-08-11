import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';


import '../config/palette.dart';

class EventPage extends StatelessWidget {
  final int eventID;
  const EventPage({ Key? key, required this.eventID }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: change eventId to our param
    final String getEventById = """
        query getEventById {
          event(eventId: "1") {
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
            padding: EdgeInsets.all(30.0),
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Palette.secondary_background,
              borderRadius: BorderRadius.circular(40.0)
            ),
            child: renderContent(
              event['name'],
              event['location'],
              event['date'].substring(5, 7),
              event['date'].substring(8, 10),
              event['date'],
              'Team meeting to brief each other on our progress and decide next steps.') //not sure
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
                        Text(month, style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal)),
                        Text(day, style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold))
                      ]   
                    )
                  ],
                ),
                // title, location, time
                Column(
                  children: [
                    // title
                    Text(eventName, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                    // location
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 12, 0, 0),
                      child: Column(
                        children: [
                          Text(location, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300, fontStyle: FontStyle.italic)),
                          ],
                      )
                    ),
                    // time
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 2, 0, 24),
                      child: Text(time, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300, fontStyle: FontStyle.italic)
                      )
                    ),
                  ],
                ),
                // description 
                renderSection('Description', description),
                SizedBox(height: 42,), // add spacing b/w sections
                renderSection('Attendees', 'TBD'),
                SizedBox(height: 42,),
                renderSection('Discussion', 'TBD'),
                // button
                // renderButton('Register')
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
                    Text(heading, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis),
                    const Divider(
                      color: Palette.primary_text,
                      height: 16,
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

  Widget renderButton(String mode){
    return ElevatedButton(onPressed: () {}, child: Text(mode));
  }
}