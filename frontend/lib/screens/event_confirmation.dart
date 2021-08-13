import 'package:flutter/material.dart';
import 'package:frontend/config/palette.dart';
import 'package:frontend/screens/browse_events.dart';
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

class EventConfirmation extends StatefulWidget {
  final ScreenType screen;
  EventConfirmation({Key? key, required this.screen}) : super(key: key);

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
  State<StatefulWidget> createState() => _EventConfirmationState();
}

class _EventConfirmationState extends State<EventConfirmation> {
  TextEditingController txtId = TextEditingController();
  TextEditingController txtFirstName = TextEditingController();
  TextEditingController txtLastName = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  final TextEditingController txtPassword =
      TextEditingController(); //passwordController
  final TextEditingController confirmTxtPassword =
      TextEditingController(); //confirmPasswordController
  Icon button = Icon(Icons.keyboard_return_rounded);

  GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();
  QueryMutation addMutation = QueryMutation();

  //final Account account;
  //final bool isAdd;

  _EventConfirmationState();
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
    return Scaffold(
      appBar: CustomBar(widget.screen, false), //display a custom title
      body: Container(
        padding: EdgeInsets.symmetric(
          vertical: 35.0,
          horizontal: 10.0,
        ),
        child: Column(
          children: [
            _buildForm(formKey: _formKey),
            SizedBox(
              height: 15,
            ),
            ElevatedButton(
              onPressed: _registerPressed,
              //style: ButtonStyle(padding: EdgeInsets.all(0.0), ),
              child: const Text('Add to calendar', style: TextStyle(fontSize: 11)),
              style: ElevatedButton.styleFrom(primary: Palette.highlight_1),
            ),
          ],
        ),
      ),

      // bottomNavigationBar: BottomNav(
      //   screen: widget.screen,
      // ),
      // bottomNavigationBar: BottomNav(
      //   screen: widget.screen,
      // ),
    );
  }

  void _registerPressed() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => DisplayEvents(screen: ScreenType.Browse, mode: EventButtonMode.Register,)));
    print('Event Confirmation pressed');
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
              child: RichText(
                overflow: TextOverflow.clip,



                
                text: TextSpan(
                  text: 'You\'re registered for an event! \n\n',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Palette.highlight_1),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Event Name:  \n\n',
                      style: DefaultTextStyle.of(context).style,
                    ),
                    TextSpan(
                      text: 'Event Date:  \n\n',
                      style: DefaultTextStyle.of(context).style,
                    ),
                    TextSpan(
                      text: 'Start Time:  \n\n',
                      style: DefaultTextStyle.of(context).style,
                    ),
                    TextSpan(
                      text: 'End Time:  \n\n',
                      style: DefaultTextStyle.of(context).style,
                    ),
                    TextSpan(
                      text: 'Tag  \n\n',
                      style: DefaultTextStyle.of(context).style,
                    ),
                    TextSpan(
                      text: 'Event Location:  \n\n',
                      style: DefaultTextStyle.of(context).style,
                    ),
                    TextSpan(
                      text:
                          'Event Description:Super long unbolded text here \n',
                      style: DefaultTextStyle.of(context).style,
                    ),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
