import 'package:flutter/material.dart';
import '../config/palette.dart';

class RegisterButton extends StatefulWidget {
  const RegisterButton({ Key? key }) : super(key: key);

  @override
  _RegisterButtonState createState() => _RegisterButtonState();
}

class _RegisterButtonState extends State<RegisterButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _registerPressed, 
       //style: ButtonStyle(padding: EdgeInsets.all(0.0), ),
      child: const Text('Register', style: TextStyle(fontSize: 10)),
      style: ElevatedButton.styleFrom(primary: Palette.highlight_1), 
      );
  }

  void _registerPressed() {
      Navigator.of(context).pop();
      //Navigator.push(context, MaterialPageRoute(builder: (context) => DummyPage()));
      print('register pressed');
    }
}