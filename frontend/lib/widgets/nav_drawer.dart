// side menu that pops up when you click the hamburger icon

import '../main.dart';
import 'package:flutter/material.dart';

//screens
import '../screens/dummy.dart';
import '../screens/eventgoingpg.dart';
import '../screens/display_events.dart';
import '../screens/screen_type.dart';

class NavDrawer extends StatelessWidget {
  final padding = EdgeInsets.symmetric(horizontal: 20);

  @override
  Widget build(BuildContext context) {
    // Menu items
    return Drawer(
      child: Material(
        // Use material instead of container so it's clickable?
        child: ListView(
          padding: padding,
          children: <Widget>[
            // main menu items
            const SizedBox(
              height: 48,
            ),
            buildMenuItem(
                text: 'Browse Events',
                icon: Icons.view_list,
                onClicked: () => selectedItem(context, 0)),
            const SizedBox(
              height: 16,
            ),
            buildMenuItem(
                text: 'Create Event',
                icon: Icons.add,
                onClicked: () => selectedItem(
                    context, 1) //uncomment when the page has been created
                ),
            const SizedBox(
              height: 16,
            ),
            buildMenuItem(
                text: 'My Events',
                icon: Icons.event,
                onClicked: () => selectedItem(context, 2)),
            const SizedBox(
              height: 16,
            ),
            buildMenuItem(
              text: 'Events I\'m Attending',
              icon: Icons.event_available,
              // onClicked: () => selectedItem(context, 3)
            ),
            // divider
            const SizedBox(
              height: 24,
            ),
            Divider(
              color: Colors.black54,
            ),
            const SizedBox(
              height: 16,
            ),
            // profile and settings
            const SizedBox(
              height: 16,
            ),
            buildMenuItem(
              text: 'Profile',
              icon: Icons.person,
              // onClicked: () => selectedItem(context, 4)
            ),
            const SizedBox(
              height: 16,
            ),
            buildMenuItem(
              text: 'Settings',
              icon: Icons.settings,
              // onClicked: () => selectedItem(context, 5)
            ),
            const SizedBox(
              height: 16,
            ),
            buildMenuItem(
                text: 'Log out',
                icon: Icons.exit_to_app,
                onClicked: () => selectedItem(context, 6)),
          ],
        ),
      ),
    );
  }

  Widget buildMenuItem(
      {required String text, required IconData icon, VoidCallback? onClicked}) {
    final color = Colors.black54;
    final hoverColor = Colors.red;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text, style: TextStyle(color: color)),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop(); // before switching pages, close the menu
    switch (index) {
      case 0:
        print('Browse events clicked');
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => DisplayEvents(screen: ScreenType.Browse,)));
        break;
      case 1:
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => DummyPage()));
        break;
      case 2:
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => EventGoingPg()));
        break;
      // case 3:
      //   Navigator.of(context).push(MaterialPageRoute(builder: (context) => YourPageName()));
      //   break;
      // case 4:
      //   Navigator.of(context).push(MaterialPageRoute(builder: (context) => YourPageName()));
      //   break;
      // case 5:
      //   Navigator.of(context).push(MaterialPageRoute(builder: (context) => YourPageName()));
      //   break;
      case 6:
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => LoginPage(title: 'Log in')));
        break;
    }
  }
}
