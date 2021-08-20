import 'package:flutter/material.dart';
import 'package:frontend/widgets/custom_bar.dart';
import 'package:frontend/widgets/nav_drawer.dart';
import 'package:frontend/widgets/bottom_nav.dart';
import 'package:frontend/config/palette.dart';
import 'screen_type.dart';

/// Dummy page to be used as a placeholder during development
class DummyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CustomBar(ScreenType.Create, false),
                    body: const Text('This is a dummy page'),
                    bottomNavigationBar: BottomNav(screen: ScreenType.Create,),
    );
  }
}