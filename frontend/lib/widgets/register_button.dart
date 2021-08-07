
import 'package:flutter/material.dart';

class RegisterButton extends StatelessWidget {
  const RegisterButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _registerPressed, 
       //style: ButtonStyle(padding: EdgeInsets.all(0.0), ),
      child: const Text('Register', style: TextStyle(fontSize: 11)) );
  }

  void _registerPressed() {
      // Navigator.push(context, MaterialPageRoute(builder: (context) => BrowseEvents()));
      print('register pressed');
    }
}