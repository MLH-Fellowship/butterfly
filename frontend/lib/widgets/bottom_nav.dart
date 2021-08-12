import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/screens/dummy.dart';
import 'package:frontend/screens/display_events.dart';
import 'package:frontend/config/palette.dart';
import 'package:frontend/screens/eventpg.dart';
import 'package:frontend/screens/create_event_form.dart';
import '../screens/screen_type.dart';

class BottomNav extends StatefulWidget {
  final ScreenType screen;
  // final int pageIndex;
  const BottomNav({ Key? key, required this.screen }) : super(key: key);

  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _selectedIndex = 0; // determines which page to route to
  List<Widget> _navItems = [
    DisplayEvents(screen: ScreenType.Browse,),
    CreateEventForm(screen: ScreenType.CreateEventForm,),
    DisplayEvents(screen: ScreenType.Hosting,),
    DisplayEvents(screen: ScreenType.Attending,),
    DummyPage(),
  ];

  void _onItemTap(int index){
    setState(() {
      _selectedIndex = index;
    });
    // We don't pop, bc we want to return to this pg when we dismiss the event page
    // Navigator.of(context).push(MaterialPageRoute(builder: (context) => _navItems.elementAt(_selectedIndex)));
    Navigator.push(context, PageRouteBuilder(
        opaque: false,
        transitionDuration: Duration.zero,
        pageBuilder: (BuildContext context, _, __) {
          //return Center(child: Text('My PageRoute'));
          return _navItems.elementAt(_selectedIndex);
        }
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    
    setState(() {
      _selectedIndex = widget.screen.index;
    });

    // print(_selectedIndex);
    print(widget.screen.index);
    return BottomNavigationBar(
      backgroundColor: Palette.secondary_background,
      unselectedItemColor: Palette.primary_text,
      selectedItemColor: Palette.highlight_1,
      type: BottomNavigationBarType.fixed, //disable selected icon animation
      selectedFontSize: 14, // keep font size uniform
      unselectedFontSize: 14,
      showUnselectedLabels: true,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: const Icon(CupertinoIcons.list_dash),
          label: 'Browse'
        ),
        BottomNavigationBarItem(
          icon: const Icon(CupertinoIcons.plus_app),
          label: 'Create'
        ),
        BottomNavigationBarItem(
          icon: const Icon(CupertinoIcons.music_mic),
          label: 'Hosting'
        ),
        BottomNavigationBarItem(
          icon: const Icon(CupertinoIcons.checkmark_square),
          label: 'Attending'
        ),
        BottomNavigationBarItem(
          icon: const Icon(CupertinoIcons.person_crop_circle),
          label: 'Profile'
        ),
      ],
      // currentIndex: _selectedIndex,
      currentIndex: widget.screen.index,
      onTap: _onItemTap, // excl () bc we only call this func when we tap. Having () means we call it indefinitely
    );
  }
}