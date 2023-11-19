import 'package:flutter/material.dart';
import 'package:layout_concepts/joke_app.dart';
import 'package:provider/provider.dart';

class JokeNavBar extends StatefulWidget {
  final Function onDestinationSelected;
  JokeNavBar({required this.onDestinationSelected});

  @override
  State<JokeNavBar> createState() => _JokeNavBarState();
}

class _JokeNavBarState extends State<JokeNavBar> {


  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppData>();

    return NavigationBar(
        selectedIndex: appState.navBarIndex,
        onDestinationSelected: (newIndex) {
          setState(() => appState..navBarIndex = newIndex);
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
