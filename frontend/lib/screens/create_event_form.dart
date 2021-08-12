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
  final TextEditingController txtPassword =
      TextEditingController(); //passwordController
  final TextEditingController confirmTxtPassword =
      TextEditingController(); //confirmPasswordController
  Icon button = Icon(Icons.keyboard_return_rounded);

  GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();
  QueryMutation addMutation = QueryMutation();

  //final Account account;
  //final bool isAdd;

  _CreateEventFormState();
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
      bottomNavigationBar: BottomNav(
        screen: ScreenType.Create,
      ),
    );
  }

  void _registerPressed() {
    Navigator.of(context).pop();
    //Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
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
              child: TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Event name required';
                  } else if (value.length < 3) {
                    return 'Event name must be at least 3 characters long.';
                  }
                  return null;
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
              child: TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Date required';
                  } else if (value.length < 3) {
                    return 'Date must be at least 3 characters long.';
                  }
                  return null;
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
              child: TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Start Time required';
                  } else if (value.length < 3) {
                    return 'Start Time must be at least 3 characters long.';
                  }
                  return null;
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
              child: TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'End Time required';
                  } else if (value.length < 3) {
                    return 'End Time not valid.';
                  }
                  return null;
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
              child: TextFormField(
                obscureText: true,
                //controller: txtPassword,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Tag required';
                  } else if (value.length < 3) {
                    return 'Tag must be at least 3 characters long.';
                  }
                  return null;
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
              child: TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Enter location',
                  hintText: 'Enter location',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Enter description',
                  hintText: 'Enter description',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                ),
              ),
            ),
          ],
        ));
  }
}
