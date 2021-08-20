import 'package:flutter/material.dart';
import 'package:frontend/config/palette.dart';
import 'package:frontend/screens/display_events.dart';
import 'package:frontend/screens/event_button_mode.dart';
import 'package:frontend/screens/screen_type.dart';
import 'package:frontend/widgets/bottom_nav.dart';
import 'package:frontend/widgets/custom_bar.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../../graphql_conf.dart';
import '../../query_mutation.dart';
import '../models/account.dart';
import '../widgets/nav_drawer.dart';

/// Parameters to pass in the mutation
String eventName = "";
String date = "";
String startTime = "";
String endTime = "";
String tag = "";
String location = "";
String description = "";

class CreateEventForm extends StatefulWidget {
  final ScreenType screen;
  CreateEventForm({Key? key, required this.screen}) : super(key: key);

  //final String title;
  //final Account account; //Alert
  //final bool isAdd; //Alert
  //  final String updateEvent = """
//     query updateEvent {
//       updateEvent {
//         name
//         date
//         startTime
//         endTime
//         tag
//         location
//         description
//       }
//     }
//   """;

  @override
  State<StatefulWidget> createState() => _CreateEventFormState();
}

class _CreateEventFormState extends State<CreateEventForm> {
  TextEditingController txtId = TextEditingController();
  TextEditingController txtFirstName = TextEditingController();
  TextEditingController txtLastName = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  // final TextEditingController txtPassword =
  //     TextEditingController(); //passwordController
  // final TextEditingController confirmTxtPassword =
  //     TextEditingController(); //confirmPasswordController
  Icon button = Icon(Icons.keyboard_return_rounded);

  GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();
  QueryMutation addMutation = QueryMutation();

  //final Account account;
  //final bool isAdd;

  _CreateEventFormState();
  final _formKey = GlobalKey<FormState>();
  //final _passwordController = TextEditingController();
  //final _confirmPasswordController = TextEditingController();

  // @override
  // void dispose() {
  //   txtPassword.dispose();
  //   confirmTxtPassword.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final String addEvent = """
      mutation addEvent(\$input: EventInput!) {
        addEvent(input: \$input) {
            event { 
              name
              date
              startTime
              endTime
              tag
              location
              description
          }
        }
      }
      """;
    return Scaffold(
      appBar: CustomBar(widget.screen, false), //display a custom title
      body: Container(
        padding: EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 10.0,
        ),
        child: Column(
          children: [
            _buildForm(formKey: _formKey),
            SizedBox(
              height: 15,
            ),
            /// Make a mutation to add an event to the database
            Mutation(
              options: MutationOptions(
                documentNode: gql(addEvent),
                onCompleted: (dynamic resultData){
                  if(resultData?.isEmpty ?? true){
                    print('null data');
                  }
                  else{
                    print('nonnull data');
                    var data = resultData.data["addEvent"];

                    setState(() {
                      eventName = data['name'];
                      date = data['date'];
                      startTime = data['startTime'];
                      endTime = data['endTime'];
                      tag = data['tag'];
                      location = data['location'];
                      description = data['description'];
                    });

                    print("mutation added: ${data}");
                  }
                },
                onError: (err) {
                  print(err.graphqlErrors);
                },
              ), 
              builder: (RunMutation runMutation, QueryResult result){
                // next & submit button
                return ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()){
                      debugPrint('All fields entered.');
                      print('submit pressed');
                      runMutation({
                        "input": {
                          "name": eventName,
                          "date": date,
                          "startTime": startTime,
                          "endTime": endTime,
                          "tag": tag,
                          "user": "1", 
                          "location": location,
                          "description": description
                        }
                      });
                      Navigator.push(context, PageRouteBuilder(
                      opaque: false,
                      transitionDuration: Duration.zero,
                      pageBuilder: (BuildContext context, _, __) {
                        return DisplayEvents(screen: ScreenType.Hosting, mode: EventButtonMode.Delete);
                      }
                    )
    );
                    }
                    
                  },
                  //style: ButtonStyle(padding: EdgeInsets.all(0.0), ),
                  child: const Text('Submit', style: TextStyle(fontSize: 11)),
                  style: ElevatedButton.styleFrom(primary: Palette.highlight_1),
                );
                },
              ),
              
            ]
              //child: Icon(Icons.keyboard_return_rounded),
          )   
        ),
        bottomNavigationBar: BottomNav(screen: ScreenType.Create),
      );
  }

  void _submitPressed() {
    Navigator.of(context).pop();
    //Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
    print('Event Submit pressed');
  }
}

class _buildForm extends StatelessWidget {
  const _buildForm({
    Key? key,
    required GlobalKey<FormState> formKey,
  })  : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormState> _formKey;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              // event name
              child: TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Event name required';
                  } else if (value.length < 3) {
                    return 'Event name must be at least 3 characters long.';
                  }
                  else{
                    eventName = value;
                    return null;
                  }
                },
                decoration: InputDecoration(
                  labelText: 'Event name',
                  hintText: 'Enter your event name',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              // date
              child: TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Date required';
                  } else if (value.length < 3) {
                    return 'Date must be at least 3 characters long.';
                  }
                  else{
                    date = value;
                    return null;
                  }
                },
                decoration: InputDecoration(
                  labelText: 'Date',
                  hintText: 'Enter Date',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              // startTime
              child: TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Start Time required';
                  } else if (value.length < 3) {
                    return 'Start Time must be at least 3 characters long.';
                  }
                  else{
                    startTime = value;
                    return null;
                  }
                },
                decoration: InputDecoration(
                  labelText: 'Start Time',
                  hintText: 'Enter Start Time',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              // end time
              child: TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'End Time required';
                  } else if (value.length < 3) {
                    return 'End Time not valid.';
                  }
                  else{
                    endTime = value;
                    return null;
                  }
                },
                decoration: InputDecoration(
                  labelText: 'End Time',
                  hintText: 'Enter End Time',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              // tag
              child: TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Tag required';
                  } else if (value.length < 3) {
                    return 'Tag not valid.';
                  }
                  else{
                    tag = value;
                    return null;
                  }
                },
                decoration: InputDecoration(
                  labelText: 'Tag',
                  hintText: 'Enter Tag',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              // location
              child: TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Location required';
                  } else if (value.length < 3) {
                    return 'Location not valid.';
                  }
                  else{
                    location = value;
                    return null;
                  }
                },
                decoration: InputDecoration(
                  labelText: 'Location',
                  hintText: 'Enter Location',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              // description
              child: TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Description required';
                  } else if (value.length < 3) {
                    return 'Description not valid.';
                  }
                  else{
                    description = value;
                    return null;
                  }
                },
                decoration: InputDecoration(
                  labelText: 'Description',
                  hintText: 'Enter Description',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                ),
              ),
            ),
          ],
        ));
  }
}
