import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:frontend/widgets/nav_drawer.dart';
import 'package:lottie/lottie.dart';
import 'login.dart';
import 'signup.dart';
// import '../widgets/palette.dart';

class LandingPg extends StatefulWidget {
  const LandingPg({Key? key}) : super(key: key);

  @override
  _LandingPgState createState() => _LandingPgState();
}

class _LandingPgState extends State<LandingPg> with TickerProviderStateMixin {
  late final AnimationController _logoController;
  late final AnimationController _buttonsController;

  @override
  void initState() {
    super.initState();

    _logoController = AnimationController(
      vsync: this,
      //animate fade in
      duration: Duration(milliseconds: 400),
    );
    _logoController.forward();

    _buttonsController = AnimationController(
      vsync: this,
      //animate
      duration: Duration(milliseconds: 800),
    );
    _buttonsController.forward();
  }

  @override
  void dispose() {
    _logoController.dispose();
    _buttonsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      endDrawer: NavDrawer(),
      // backgroundColor: Palette.primary_background;
      backgroundColor: Color(0XFFFAEEE7),
      body: Column(
        children: [
          FadeTransition(
            opacity: _logoController,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(40.0),
                  child: Text(
                    'butterfly',
                    style: TextStyle(
                      fontSize: 60,
                    ),
                  ),
                ),
                butterflyLottie(),
              ],
            ),
          ),
          FadeTransition(
            opacity: _buttonsController,
            child: Column(
              children: [
                //login(),
                //signup(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget butterflyLottie() {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Lottie.asset(
        "assets/lottie/butterfly.json",
        fit: BoxFit.cover,
        alignment: Alignment.topCenter,
        repeat: true,
      ),
    );
  }
}

// @TODO:  replace this widget with a StatelessWidget
class ButterflyTitle extends StatefulWidget {
  final AnimationController txtController;
  const ButterflyTitle({Key? key, required this.txtController})
      : super(key: key);

  @override
  _ButterflyTitleState createState() => _ButterflyTitleState();
}

class _ButterflyTitleState extends State<ButterflyTitle> {
  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: widget.txtController,
      child: Text(
        'butterfly',
        style: TextStyle(
          fontSize: 60,
        ),
      ),
    );
  }
}
