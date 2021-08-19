import 'package:flutter/material.dart';
import 'package:frontend/config/palette.dart';
import 'package:frontend/screens/screen_type.dart';
import 'package:frontend/widgets/bottom_nav.dart';
import 'package:frontend/widgets/custom_bar.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../../graphql_conf.dart';
import '../../query_mutation.dart';
import '../models/account.dart';
import '../widgets/nav_drawer.dart';
import 'display_events.dart';
import 'event_button_mode.dart';
import 'event_confirmation.dart';

String name = "";
String email = "";

class EventRegister extends StatefulWidget {
  final ScreenType screen;
  final String eventID;
  EventRegister({Key? key, required this.screen, required this.eventID}) : super(key: key);

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
  State<StatefulWidget> createState() => _EventRegisterState();
}

class _EventRegisterState extends State<EventRegister> {
  TextEditingController txtId = TextEditingController();
  TextEditingController txtFirstName = TextEditingController();
  TextEditingController txtLastName = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  final TextEditingController txtPassword =
      TextEditingController(); //passwordController
  final TextEditingController confirmTxtPassword =
      TextEditingController(); //confirmPasswordController

  //final Account account;
  //final bool isAdd;

  _EventRegisterState();
  final _formKey = GlobalKey<FormState>();
  //final _passwordController = TextEditingController();
  //final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    txtPassword.dispose();
    confirmTxtPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String registerForEvent = """
      mutation addAttendees(\$eventId: ID!, \$userId: ID!) {
        addAttendees(eventId: \$eventId, userId: \$userId) {
          event {
            id
            name
            attendees {
              name
              id
            }
          }
        }
      }
      """;
    //debug
    print('Create Event called');
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
            Mutation(
              options: MutationOptions(
                documentNode: gql(registerForEvent),
                onCompleted: (dynamic resultData){
                  if(resultData?.isEmpty ?? true){
                    print('null data');
                  }
                  else{
                    print('nonnull data');
                    var data = resultData.data["addAttendees"];

                    setState(() {
                      
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
                          "eventId": widget.eventID,
                          "userId": "1",
                      });
                      Navigator.push(context, PageRouteBuilder(
                        opaque: false,
                        transitionDuration: Duration.zero,
                        pageBuilder: (BuildContext context, _, __) {
                          return DisplayEvents(screen: ScreenType.Attending, mode: EventButtonMode.Cancel);
                        }
                      )
                      );
                    }
                    
                  },
                  //style: ButtonStyle(padding: EdgeInsets.all(0.0), ),
                  child: const Text('Register', style: TextStyle(fontSize: 11)),
                  style: ElevatedButton.styleFrom(primary: Palette.highlight_1),
                );
                },
              ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNav(screen: ScreenType.Browse,),
    );
  }

  void _registerPressed() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EventConfirmation(
                  screen: ScreenType.EventConfirmation,
                )));
    print('Event Register pressed');
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
              // name
              child: TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Name required';
                  } else if (value.length < 3) {
                    return 'Name must be at least 3 characters long.';
                  }
                  else{
                    name = value;
                    return null;
                  }
                },
                decoration: InputDecoration(
                  labelText: 'Name',
                  hintText: 'Enter your Name',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              // email
              child: TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Email required';
                  } else if (value.length < 3) {
                    return 'Email must be at least 3 characters long.';
                  }
                  else{
                    email = value;
                    return null;
                  }
                },
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'Enter Email',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                ),
              ),
            ),
          ],
        ));
  }
}
