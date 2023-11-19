import 'package:flutter/material.dart';
import 'package:layout_concepts/joke_add_page.dart';
import 'package:layout_concepts/joke_nav_bar.dart';
import 'package:layout_concepts/joke_profile_app.dart';
import 'package:layout_concepts/joke_view.dart';
import 'package:provider/provider.dart';
import 'package:lorem_ipsum/lorem_ipsum.dart';

class JokeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppData(),
      child: AppEntry(),
    );
  }
}

class AppData extends ChangeNotifier {
  List<JokeData> _jokeDataList = [];
  int navBarIndex = 0;

  List<JokeData> get jokeDataList {
    return List.unmodifiable(_jokeDataList);
  }

  void addJoke(JokeData jokeData) {
    _jokeDataList.add(jokeData);
    notifyListeners();
  }
}

class AppEntry extends StatefulWidget {
  @override
  State<AppEntry> createState() => _AppEntryState();
}

class Page extends StatelessWidget {
  Widget buildAllPosts(BuildContext context) {
    var appState = context.watch<AppData>();

    return ListView(
      children: appState.jokeDataList.map((e) => JokeView(e)).toList(),
    );
  }

  Widget build(BuildContext context) {
    var appState = context.watch<AppData>();
    if (appState.navBarIndex == 0) return buildAllPosts(context);
    if (appState.navBarIndex == 1) return JokeAddPage();
    if (appState.navBarIndex == 2) return JokeProfileApp();
    return ErrorWidget(Exception("Invalid navigation destination!"));
  }
}

class _AppEntryState extends State<AppEntry> {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppData>();

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Page(),
          ),
          JokeNavBar(
            onDestinationSelected: (index) =>
                setState(() => appState.navBarIndex = index),
          )
        ],
      ),
    );
  }
}
