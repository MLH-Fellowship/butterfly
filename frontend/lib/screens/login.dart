import 'package:flutter/material.dart';
import 'package:frontend/main.dart';
import 'package:frontend/screens/screen_type.dart';
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
import 'create_account.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var myFocusNode;

  get account => null;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextInputField(
              key: const Key('Email'),
              icon: FontAwesomeIcons.envelope,
              hint: 'Email',
              inputType: TextInputType.emailAddress,
              onChanged: (value) {
                    email = value;
                  },
              inputAction: TextInputAction.next,
            ),
            PasswordInput(
              key: const Key('Password'),
              icon: FontAwesomeIcons.lock,
              hint: 'Password',
              inputAction: TextInputAction.done,
              inputType: TextInputType.text,
            ),
            SizedBox(
              height: 4,
            ),
            // @TODO INSERT that onPress() to ROUNDEDBUTTON to login
            RoundedButton(
              buttonName: 'Login',
              key: const Key('Login'),
            ),
            SizedBox(
              height: 1,
            ),
            TextButton(
                child: const Text('Create New Account'),
                key: const Key('Create New Account'),
                onPressed: () {
                  Route route = MaterialPageRoute(
                      builder: (context) => CreateAccount(
                            account: this.account,
                            isAdd: false,
                            screen: ScreenType.CreateAccount,
                          ));
                  Navigator.push(context, route);
                },
                style: TextButton.styleFrom(primary: Palette.highlight_1)),
          ],
        ),

      ], //Column of Scaffold
    
    );
  }

  void _registerPressed() {
    Navigator.of(context).pop();
    //Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
    print('login pressed');
  }
}
