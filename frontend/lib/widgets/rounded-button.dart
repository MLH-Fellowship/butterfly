import 'package:flutter/material.dart';
import 'package:frontend/screens/display_events.dart';
import 'package:frontend/screens/screen_type.dart';
import '../config/palette.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    Key? key,
    required this.buttonName,
  }) : super(key: key);

  final String buttonName;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.06,
      width: size.width * 0.8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Palette.highlight_2,
      ),

      //@TODO need to place in login.dart for login button
      child: TextButton(
        onPressed: () {
          Route route = MaterialPageRoute(
              builder: (context) => DisplayEvents(screen: ScreenType.Browse));
          Navigator.push(context, route);
        },
        child: Text(
          buttonName,
          style: Palette.kBodyText.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
