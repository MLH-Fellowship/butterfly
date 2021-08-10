import 'package:flutter/material.dart';
import '../models/eventgoing.dart';
import '../screens/eventpg.dart';

class EventGoingList extends StatefulWidget {
  @override
  _EventGoingListState createState() => _EventGoingListState();
}

class _EventGoingListState extends State<EventGoingList> {
  List<Widget> _eventgoingTiles = [];
  final GlobalKey _listKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _addEventGoings();
  }

  void _addEventGoings() {
    // get data from db
    List<EventGoing> _eventgoing = [
      EventGoing(
          eventName: 'MLH 1',
          date: 'date',
          time: 'time',
          location: 'location',
          description: 'description',
          attendee: 'attendee',
          discussion: 'discussion',
          img: 'i1.png'),
      EventGoing(
          eventName: 'MLH 2',
          date: 'date',
          time: 'time',
          location: 'location',
          description: 'description',
          attendee: 'attendee',
          discussion: 'discussion',
          img: 'i1.png'),
      EventGoing(
          eventName: 'MLH 3',
          date: 'date',
          time: 'time',
          location: 'location',
          description: 'description',
          attendee: 'attendee',
          discussion: 'discussion',
          img: 'i1.png'),
    ];

    _eventgoing.forEach((EventGoing event) {
      _eventgoingTiles.add(_buildTile(event));
    });
  }

  Widget _buildTile(EventGoing eventgoing) {
    return ListTile(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EventPg(eventgoing: eventgoing)));
      },
      contentPadding: EdgeInsets.all(25),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('${eventgoing.date} nights',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[300])),
          Text(eventgoing.eventName,
              style: TextStyle(fontSize: 20, color: Colors.grey[600])),
        ],
      ),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Image.asset(
          'images/${eventgoing.img}',
          height: 50.0,
        ),
      ),
      trailing: Text('\$${eventgoing.location}'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        key: _listKey,
        itemCount: _eventgoingTiles.length,
        itemBuilder: (context, index) {
          return _eventgoingTiles[index];
        });
  }
}
