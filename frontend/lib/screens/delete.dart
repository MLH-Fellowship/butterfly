import 'package:flutter/material.dart';
import 'package:frontend/main.dart';
import '../config/palette.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../../graphql_conf.dart';
import '../../query_mutation.dart';
import '../models/account.dart';
import '../widgets/nav_drawer.dart';

class Delete extends StatefulWidget {
  const Delete({ Key? key }) : super(key: key);

  @override
  _DeleteState createState() => _DeleteState();
}

class _DeleteState extends State<Delete> {
  @override
  
  Widget build(BuildContext context) {
    return 
      ElevatedButton(
      onPressed: _registerPressed, 
       //style: ButtonStyle(padding: EdgeInsets.all(0.0), ),
      child: const Text('Register', style: TextStyle(fontSize: 11)),
      style: ElevatedButton.styleFrom(primary: Palette.highlight_1), 
      );
    // Stack(
    //   children: [
    //     BackgroundImage(
    //       image: 'assets/images/login_bg.png',
    //     ),
    //     Scaffold(
    //       backgroundColor: Colors.transparent,
    //       body: Column(
    //         children: [
    //           Flexible(
    //             child: Center(
    //               child: Text(
    //                 'Foodybite',
    //                 style: TextStyle(
    //                     color: Colors.white,
    //                     fontSize: 60,
    //                     fontWeight: FontWeight.bold),
    //               ),
    //             ),
    //           ),
    //           Column(
    //             crossAxisAlignment: CrossAxisAlignment.end,
    //             children: [
    //               TextInputField(
    //                 icon: FontAwesomeIcons.envelope,
    //                 hint: 'Email',
    //                 inputType: TextInputType.emailAddress,
    //                 inputAction: TextInputAction.next,
    //               ),
    //               PasswordInput(
    //                 icon: FontAwesomeIcons.lock,
    //                 hint: 'Password',
    //                 inputAction: TextInputAction.done,
    //               ),
    //               GestureDetector(
    //                 onTap: () => Navigator.pushNamed(context, 'ForgotPassword'),
    //                 child: Text(
    //                   'Forgot Password',
    //                   style: kBodyText,
    //                 ),
    //               ),
    //               SizedBox(
    //                 height: 25,
    //               ),
    //               RoundedButton(
    //                 buttonName: 'Login',
    //               ),
    //               SizedBox(
    //                 height: 25,
    //               ),
    //             ],
    //           ),
    //           GestureDetector(
    //             onTap: () => Navigator.pushNamed(context, 'CreateNewAccount'),
    //             child: Container(
    //               child: Text(
    //                 'Create New Account',
    //                 style: kBodyText,
    //               ),
    //               decoration: BoxDecoration(
    //                   border:
    //                       Border(bottom: BorderSide(width: 1, color: kWhite))),
    //             ),
    //           ),
    //           SizedBox(
    //             height: 20,
    //           ),
    //         ],
    //       ),
    //     )
    //   ],
    // );
  }
    void _registerPressed() {
      Navigator.of(context).pop();
      //Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
      print('login pressed');
    }
}