// Browse events screen
// import 'dart:html';
import 'dart:ui';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../widgets/nav_drawer.dart';
import '../widgets/register_button.dart';
import '../get_all_events.dart';

class BrowseEvents extends StatelessWidget {
  const BrowseEvents() : super();

  @override
  Widget build(BuildContext context) {
    final httpLink = HttpLink(
      uri: "http://127.0.0.1:8000/graphql",
    );

    final client = ValueNotifier(
      GraphQLClient(
        link: httpLink,
        cache: OptimisticCache(dataIdFromObject: typenameDataIdFromObject),
      ),
    );

    return GraphQLProvider(
      client: client,
      child: const CacheProvider(
        child: EventList(),
      ),
    );
  }
}

class EventList extends StatefulWidget {
  const EventList({
    Key? key,
  }) : super(key: key);

  @override
  _EventListState createState() => _EventListState();
}

class _EventListState extends State<EventList> {
  final String getAllEvents = """
    query getAllEvents {
      allEvents {
        id
        name
        date  
        tag
        organizer
        location
      }
    }
  """;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Query(
              options: QueryOptions(
                documentNode: gql(getAllEvents),
                fetchPolicy: FetchPolicy.networkOnly,
              ),
              builder: (QueryResult? result,
                  {VoidCallback? refetch, FetchMore? fetchMore}) {
        
                final events = (result!.data['allEvents']);

                return Expanded(
                  child: ListView.builder(
                    itemCount: events.length,
                    itemBuilder: (BuildContext context, int index) {
                      final event = events[index];
                      return ListTile(
                        title: Text(event['title']),
                        subtitle: Text(event['description']),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

//   @override
//   Widget build(BuildContext context) {
//     return Query(
//       options: QueryOptions(
//         documentNode:
//             gql(getAllEvents), // this is the query string you just created
//       ),
//       builder: (QueryResult result,
//           {VoidCallback? refetch, required FetchMore? fetchMore}) {
//         // if (result.hasException) {
//         //   return Text(result.exception.toString());
//         // }

//         // it can be either Map or List
//         List events = result.data['allEvents'];

//         return ListView.builder(
//             itemCount: events.length,
//             itemBuilder: (context, index) {
//               final event = events[index];

//               return Text(event['name']);
//             });
//       },
//     );
//   }
// }

// class BrowseEvents extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // render each event as a card
//     return Scaffold(
//         endDrawer: NavDrawer(),
//         appBar: AppBar(title: const Text('Browse Events')),
//         body: ListView(
//           padding: EdgeInsets.fromLTRB(2, 5, 2, 5), //add padding to outside of the cards
//           children: <Widget>[
//             for(var i=0; i<3; i++) buildEventCard()
//           ],
//         ));
//   }

// Widget buildEventCard() => Card(
//       // make corners rounded
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
//       // add drop shadow
//       shadowColor: Colors.grey.withOpacity(0.5),
//       elevation: 5,
//       margin: EdgeInsets.all(12),
//       child: InkWell( // wrap in gesture detector to make card clickable
//         onTap: _cardTapped,
//         borderRadius: BorderRadius.all(Radius.circular(50)),
//         child:
//       Container(
//         padding: EdgeInsets.all(18),
//         child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           buildCardLeft(
//             eventName: 'Martha\'s Birthday Bash',
//             location: '1234 W Sample St, Vancouver, BC',
//             time: '6:00pm - 11:00pm',
//             description: 'Celebrating Martha\'s 75th birthday'
//           ),
//           Container(
//             padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
//             child: buildCardRight(
//               month: 'NOV',
//               day: '4'
//             ),
//           )
//         ],)
//       )
//     )
//   );

//     // card text in left col
//     Widget buildCardLeft({required String eventName, required String location, required String time, required String description }) {
//       print(eventName);
//       return Column(
//       crossAxisAlignment: CrossAxisAlignment.start, //left-aligned
//       children: [
//         Container(
//           child: Text(eventName, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),)
//         ),
//         Container(
//           padding: EdgeInsets.fromLTRB(0, 4, 0, 0),
//           child: Text(location, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300, fontStyle: FontStyle.italic)
//           )
//         ),
//         Container(
//           padding: EdgeInsets.fromLTRB(0, 2, 0, 0),
//           child: Text(time, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300, fontStyle: FontStyle.italic)
//           )
//         ),
//         Container(
//           padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
//           child: Text(description, style: TextStyle(fontSize: 15), overflow: TextOverflow.ellipsis)
//         )
//       ]
//     );
//   }

//     // date and registration button in card's right col
//     Widget buildCardRight({required String month, required String day}){
//       return Column(
//       crossAxisAlignment: CrossAxisAlignment.center, //left-aligned
//       children: [
//         Container(
//           child: Text(month, style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),)
//         ),
//         Container(
//           padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
//           child: Text(day, style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)
//           )
//         ),
//         RegisterButton()
//       ]
//     );
//   }

//   void _cardTapped(){
//     print('card tapped');
//   }

// }
