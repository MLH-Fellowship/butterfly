// dummy page for testing
import 'package:flutter/material.dart';
import 'nav_drawer.dart';

class DummyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        endDrawer: NavDrawer(),
        appBar: AppBar(title: const Text('Dummy')),
        body: const Text('This is a dummy page')
        );
  }
}