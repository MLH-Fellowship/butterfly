//IMPORTANT @TODO: replace account.dart with a new event (hosting) list.dart
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../../graphql_conf.dart';
import '../../query_mutation.dart';
import '../models/account.dart';
import '../widgets/nav_drawer.dart';
import '../widgets/exp_datetime.dart';
import 'package:flutter/services.dart';

class EventForm extends StatefulWidget {
  //this.title?
  EventForm({Key? key, required this.account, required this.isAdd})
      : super(key: key);

  //final String title;
  final Account account; //Alert
  final bool isAdd; //Alert

  @override
  //_EventFormState createState() => _EventFormState();
  State<StatefulWidget> createState() =>
      _EventFormState(this.account, this.isAdd);
}

class _EventFormState extends State<EventForm> {
  TextEditingController txtId = TextEditingController();
  TextEditingController txtFirstName = TextEditingController();
  TextEditingController txtLastName = TextEditingController();
  TextEditingController txtEmail = TextEditingController();

  Icon button = Icon(Icons.keyboard_return_rounded);

  GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();
  QueryMutation addMutation = QueryMutation();

  final Account account;
  final bool isAdd;

  _EventFormState(this.account, this.isAdd);
  final _formKey = GlobalKey<FormState>();
  //final _passwordController = TextEditingController();
  //final _confirmPasswordController = TextEditingController();

//reset state:
  // @override 
  // void dispose() {
  //   txtPassword.dispose();

  //   super.dispose();
  // }

  @override //CAUSED GETID() ISSUE
  // void initState() {
  //   super.initState();
  //   if (!this.isAdd) {
  //     txtId.text = account.getId();
  //     txtFirstName.text = account.getFirstName();
  //     txtLastName.text = account.getLastName();
  //     txtEmail.text = account.getEmail();
  //     txtPassword.text = account.getPassword();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: NavDrawer(),
      appBar: AppBar(title: const Text('Create an Event')),
      body: Container(
          padding: EdgeInsets.symmetric(
            vertical: 50.0,
            horizontal: 10.0,
          ),
          child: _buildForm(formKey: _formKey)
          //   child: _buildForm(),
          // ),
          // floatingActionButton: FloatingActionButton(
          //   onPressed: () {
          //     if (_formKey.currentState!.validate()) {
          //       debugPrint('All validations passed!!!');
          //     }
          //   },
          //   child: Icon(Icons.done),
          ),
      floatingActionButton: FloatingActionButton(
        child: button,
        onPressed: () => setState(() {
          if (_formKey.currentState!.validate()) {
            debugPrint('All fields entered.');

            button = Icon(Icons.done);
            debugPrint('submit clicked');
          }
        }),
        //child: Icon(Icons.keyboard_return_rounded),
      ),
    );
  }

  // Form _buildForm() {
  //   return Form(
  //     key: _formKey,
  //     child: Column(
  //       children: <Widget>[
  // Padding(
  //   padding: const EdgeInsets.all(8.0),
  //   child: TextFormField(
  //     validator: (String value){
  //       if (value.isEmpty) {
  //         return 'Username cannot be empty';
  //       }
  //       return null;
  //     },
  //     keyboardType: TextInputType.phone,
  //     decoration: InputDecoration(
  //       labelText: 'Mobile',
  //       border: OutlineInputBorder(
  //           borderRadius: BorderRadius.circular(20.0)),
  //     ),
  //   ),
  // ),
  // Padding(
  //   padding: const EdgeInsets.all(8.0),
  //   child: TextFormField(
  //     validator: (String value) {
  //       if (value.isEmpty) {
  //         return 'Username cannot be empty';
  //       } else if (value.length < 3) {
  //         return 'Username must be at least 3 characters long.';
  //       }
  //       return null;
  //     },
  //     decoration: InputDecoration(
  //       labelText: 'Username',
  //       border: OutlineInputBorder(
  //           borderRadius: BorderRadius.circular(20.0)),
  //     ),
  //   ),
  // ),
  // Padding(
  //   padding: const EdgeInsets.all(8.0),
  //   child: TextFormField(
  //     obscureText: true,
  //     controller: _passwordController,
  //     validator: (String value) {
  //       if (value.isEmpty) {
  //         return 'Password cannot be empty';
  //       } else if (value.length < 6) {
  //         return 'Password must be at least 6 characters long.';
  //       }
  //       return null;
  //     },
  //     decoration: InputDecoration(
  //       labelText: 'Password',
  //       border: OutlineInputBorder(
  //           borderRadius: BorderRadius.circular(20.0)),
  //     ),
  //   ),
  // ),
  // Padding(
  //   padding: const EdgeInsets.all(8.0),
  //   child: TextFormField(
  //     obscureText: true,
  //     controller: _confirmPasswordController,
  //     validator: (String value) {
  //       if (value != _passwordController.value.text) {
  //         return 'Passwords do not match!';
  //       }
  //       return null;
  //     },
  //     decoration: InputDecoration(
  //       labelText: 'Confirm Password',
  //       border: OutlineInputBorder(
  //           borderRadius: BorderRadius.circular(20.0)),
  //     ),
  //   ),
  // ),
  //       ],
  //     ),
  //   );
  // }
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
                    return 'Event Name';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Event Name',
                  hintText: 'Enter your Event Name',
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
                    return 'Event Date';
                  }
                  //@TODO calendar
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Event Date & start time & End Time',
                  hintText: 'Choose Event Date',
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
                    return 'Event Location';
                  }
                  //@TODO
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Event Location',
                  hintText: 'Enter Event Location',
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
                    return 'Event Description';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Event Description',
                  hintText: 'Enter your Event Description',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                ),
              ),
            ),
          ],
        ));
  }
}
