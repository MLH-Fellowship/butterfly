import 'package:flutter/material.dart';
import 'package:frontend/screens/landingpg.dart';
import 'package:frontend/screens/screen_type.dart';
import 'package:frontend/widgets/bottom_nav.dart';
import 'package:frontend/widgets/custom_bar.dart';
import 'package:frontend/widgets/rounded-button.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../../graphql_conf.dart';
import '../../query_mutation.dart';
import '../models/account.dart';
import '../widgets/nav_drawer.dart';

// ignore: must_be_immutable
class CreateAccount extends StatefulWidget {
  final ScreenType screen;
  CreateAccount(
      {Key? key,
      required this.account,
      required this.isAdd,
      required this.screen,
      //required this.myFocusNode
      })
      : super(key: key);

  //final String title;
  final Account account; //Alert
  final bool isAdd; //Alert
  //late FocusNode myFocusNode;

  @override
  State<StatefulWidget> createState() =>
      _CreateAccountState(this.account, this.isAdd);
}

class _CreateAccountState extends State<CreateAccount> {
  TextEditingController txtId = TextEditingController();
  TextEditingController txtName = TextEditingController();
  //TextEditingController txtLastName = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  final TextEditingController txtPassword =
      TextEditingController(); //passwordController
  final TextEditingController confirmTxtPassword =
      TextEditingController(); //confirmPasswordController
  //Icon backButton = Icon(Icons.keyboard_return_rounded);arrow_back_ios_rounded, arrow_back_rounded, navigate_next_rounded

  Icon backButton = Icon(Icons.arrow_back_ios_new_rounded);
  Icon nextButton = Icon(Icons.keyboard_return_rounded);

  GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();
  QueryMutation addMutation = QueryMutation();

  late final Account account;
  late final bool isAdd;

  //late FocusNode myFocusNode;

  _CreateAccountState(this.account, this.isAdd);
  final _formKey = GlobalKey<FormState>();
  //final _passwordController = TextEditingController();
  //final _confirmPasswordController = TextEditingController();
  @override
  void initState() {
    super.initState();

    //myFocusNode = FocusNode();
  }

  @override
  void dispose() {
    txtPassword.dispose();
    confirmTxtPassword.dispose();
    //myFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomBar(widget.screen, false), //display a custom title
      body: ListView(
        padding: EdgeInsets.symmetric(
          vertical: 50.0,
          horizontal: 22.0,
        ),
        children: <Widget>[
          Container(
            child: Column(
              children: <Widget>[
                _buildForm(
                  formKey: _formKey,
                  //myFocusNode: this.myFocusNode,
                ),
                SizedBox(
                  height: 250,
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            padding:EdgeInsets.fromLTRB(50.0, 0.0, 0.0, 0.0),
            child: 
              FloatingActionButton(
                child: backButton,
                onPressed: () => setState(() {
                  Route route =
                      MaterialPageRoute(builder: (context) => LandingPg());
                  Navigator.push(context, route);
                }
                ),
              ),
            
          ),
          FloatingActionButton(
            heroTag: "nextBtn",
            child: nextButton,

            onPressed: () => setState(() {
              //myFocusNode.requestFocus();
              if (_formKey.currentState!.validate()) {
                debugPrint('All fields entered.');

                nextButton = Icon(Icons.done);
                debugPrint('submit clicked');
              }
            }),
            //child: Icon(Icons.keyboard_return_rounded),
          ),
        ],
      ),
            bottomNavigationBar: BottomNav(
        screen: ScreenType.Create,
      ),
    );
  }
}

// ignore: must_be_immutable
class _buildForm extends StatelessWidget {
  //removed const bc myFocusNode can't be final
  _buildForm({
    Key? key,
    required GlobalKey<FormState> formKey,
    //required this.myFocusNode,
  })  : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  //FocusNode myFocusNode;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                autofocus: true,
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
                  hintText: 'Enter your name',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                ),
                textInputAction: TextInputAction.next,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                //focusNode: myFocusNode,
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
                textInputAction: TextInputAction.next,
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
                textInputAction: TextInputAction.next,
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
                textInputAction: TextInputAction.done,
              ),
            ),
          ],
        ));
  }
}
