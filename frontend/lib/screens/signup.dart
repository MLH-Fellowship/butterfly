import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../../graphql_conf.dart';
import '../../query_mutation.dart';
import '../models/account.dart';
import '../widgets/nav_drawer.dart';

class SignUp extends StatefulWidget {
  //this.title?
  SignUp({Key? key, required this.account, required this.isAdd})
      : super(key: key);

  //final String title;
  final Account account; //Alert
  final bool isAdd; //Alert

  @override
  //_SignUpState createState() => _SignUpState();
  State<StatefulWidget> createState() => _SignUpState(this.account, this.isAdd);
}

class _SignUpState extends State<SignUp> {
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

  final Account account;
  final bool isAdd;

  _SignUpState(this.account, this.isAdd);
  final _formKey = GlobalKey<FormState>();
  //final _passwordController = TextEditingController();
  //final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    txtPassword.dispose();
    confirmTxtPassword.dispose();
    super.dispose();
  }

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
      appBar: AppBar(title: const Text('Sign Up')),
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
                    return 'Handler required';
                  } else if (value.length < 3) {
                    return 'Handler must be at least 3 characters long.';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Handler',
                  hintText: 'Enter your Handler',
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
                    return 'First name required';
                  } else if (value.length < 3) {
                    return 'First name must be at least 3 characters long.';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'First Name',
                  hintText: 'Enter your first name',
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
                    return 'Last name required';
                  } else if (value.length < 3) {
                    return 'Last name must be at least 3 characters long.';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Last Name',
                  hintText: 'Enter your last name',
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
                    return 'Email not valid.';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'Enter your email',
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
                    return 'Password required';
                  } else if (value.length < 3) {
                    return 'Password must be at least 3 characters long.';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: 'Enter desired password',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                obscureText: true,
                //controller: confirmTxtPassword,
                // validator: (value) {
                //   if (value!= txtpassword.value.text) {
                //     return ' Password do not match.';
                //   }
                //   return null;
                // },
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  hintText: 'Re-enter your password',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                ),
              ),
            ),
          ],
        ));
  }
}
