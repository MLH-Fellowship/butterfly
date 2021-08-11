import 'package:flutter/material.dart';
import 'package:frontend/main.dart';
import 'package:velocity_x/velocity_x.dart';
import '../config/palette.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../../graphql_conf.dart';
import '../../query_mutation.dart';
import '../models/account.dart';
import '../widgets/nav_drawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../widgets/loginWidgets.dart';
import '../widgets/password-input.dart';
import 'signup.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  get account => null;

  @override
  Widget build(BuildContext context) {
    return Stack(
      //Scaffold(
      //backgroundColor: Colors.transparent,
      //body: Column(
      alignment: Alignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextInputField(
              icon: FontAwesomeIcons.envelope,
              hint: 'Email',
              inputType: TextInputType.emailAddress,
              inputAction: TextInputAction.next,
            ),
            PasswordInput(
              icon: FontAwesomeIcons.lock,
              hint: 'Password',
              inputAction: TextInputAction.done,
              inputType: TextInputType.text,
            ),
            // GestureDetector(
            //   onTap: () => Navigator.pushNamed(context, 'ForgotPassword'),
            //   child: Text(
            //     'Forgot Password',
            //     style: Palette.kBodyText,
            //   ),
            // ),
            SizedBox(
              height: 4,
            ),
            // @TODO INSERT that onPress() to ROUNDEDBUTTON to login
            RoundedButton(
              buttonName: 'Login',
            ),
            SizedBox(
              height: 1,
            ),
            TextButton(
                child: const Text('Create New Account'),
                onPressed: () {
                  Route route = MaterialPageRoute(
                      builder: (context) =>
                          SignUp(account: this.account, isAdd: false));
                  Navigator.push(context, route);
                },
                style: TextButton.styleFrom(primary: Palette.highlight_1)),
          ],
        ),
        // GestureDetector(
        //   onTap: () => Navigator.pushNamed(context, 'CreateNewAccount'),
        //   child: Container(
        //     child: Text(
        //       'Create New Account',
        //       style: Palette.kBodyText,
        //     ),
        //     decoration: BoxDecoration(
        //         border: Border(
        //             bottom: BorderSide(width: 1, color: Palette.highlight_1))),
        //   ),
        // ),
        // SizedBox(
        //   height: 20,
        // ),
      ], //Column of Scaffold
      //),
    );
    //  ElevatedButton(
    // onPressed: _registerPressed,
    //  //style: ButtonStyle(padding: EdgeInsets.all(0.0), ),
    // child: const Text('Register', style: TextStyle(fontSize: 11)),
    // style: ElevatedButton.styleFrom(primary: Palette.highlight_2),
    // );

    // Scaffold(
    //   endDrawer: NavDrawer(),
    //   body: Container(
    //       padding: EdgeInsets.symmetric(
    //         vertical: 50.0,
    //         horizontal: 10.0,
    //       ),
    //       child: _buildForm(formKey: _formKey)
    //       ),
    //   floatingActionButton: FloatingActionButton(
    //     child: button,
    //     onPressed: () => setState(() {
    //       if (_formKey.currentState!.validate()) {
    //         debugPrint('All fields entered.');

    //         button = Icon(Icons.done);
    //         debugPrint('submit clicked');
    //       }
    //     }),
    //     //child: Icon(Icons.keyboard_return_rounded),
    //   ),
    // );
  }

  void _registerPressed() {
    Navigator.of(context).pop();
    //Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
    print('login pressed');
  }
}
