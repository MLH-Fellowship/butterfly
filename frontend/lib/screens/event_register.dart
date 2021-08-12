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
import 'event_confirmation.dart';

class EventRegister extends StatefulWidget {
  final ScreenType screen;
  EventRegister({Key? key, required this.screen}) : super(key: key);

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
            ElevatedButton(
              onPressed: _registerPressed,
              //style: ButtonStyle(padding: EdgeInsets.all(0.0), ),
              child: const Text('Register', style: TextStyle(fontSize: 11)),
              style: ElevatedButton.styleFrom(primary: Palette.highlight_1),
            ),
          ],
        ),
      ),

      // bottomNavigationBar: BottomNav(
      //   screen: widget.screen,
      // ),
      //bottomNavigationBar: BottomNav(screen: ScreenType.EventRegister,),
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
              padding: const EdgeInsets.all(10.0),
              child: RichText(
                overflow: TextOverflow.clip,
                text: TextSpan(
                  text: 'Event Name \n\n',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Palette.highlight_1),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Event Date: Super long bolded text here \n\n',
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
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Username required';
                  } else if (value.length < 3) {
                    return 'Username must be at least 3 characters long.';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Username',
                  hintText: 'Enter your Username',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Name required';
                  } else if (value.length < 3) {
                    return 'Name must be at least 3 characters long.';
                  }
                  return null;
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
              child: TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Email required';
                  } else if (value.length < 3) {
                    return 'Email must be at least 3 characters long.';
                  }
                  return null;
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
