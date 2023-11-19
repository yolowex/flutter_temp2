import 'package:flutter/material.dart';

class JokeNavBar extends StatefulWidget {
  final Function onDestinationSelected;

  JokeNavBar({required this.onDestinationSelected});

  @override
  State<JokeNavBar> createState() => _JokeNavBarState();
}

class _JokeNavBarState extends State<JokeNavBar> {
  int navBarIndex = 0;

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
        selectedIndex: navBarIndex,
        onDestinationSelected: (newIndex) {
          setState(() => this.navBarIndex = newIndex);
          widget.onDestinationSelected(newIndex);
        },
        destinations: [
          NavigationDestination(
              icon: Icon(Icons.people, size: 35), label: "all posts"),
          NavigationDestination(
              icon: Icon(Icons.add, size: 40), label: "add post"),
          NavigationDestination(
              icon: Icon(Icons.person, size: 35), label: "profile"),
        ]);
  }
}
