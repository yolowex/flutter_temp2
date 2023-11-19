import 'package:flutter/material.dart';
import 'package:layout_concepts/joke_add_page.dart';
import 'package:layout_concepts/joke_nav_bar.dart';
import 'package:layout_concepts/joke_profile_app.dart';
import 'package:layout_concepts/joke_view.dart';
import 'package:provider/provider.dart';

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
  PageController pageController = PageController();

  final List<JokeData> _jokeDataList = [];
  int _navBarIndex = 0;

  int get navBarIndex {
    return _navBarIndex;
  }

  set navBarIndex(newValue) {
    _navBarIndex = newValue;
    notifyListeners();
  }

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

class Page extends StatefulWidget {
  @override
  State<Page> createState() => _PageState();
}

class _PageState extends State<Page> {
  Widget buildAllPosts(BuildContext context) {
    var appState = context.watch<AppData>();
    List<Widget> children =
        appState.jokeDataList.map((e) => JokeView(e)).toList();

    if (children.isEmpty) {
      children = const <Widget>[
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Card(
                  semanticContainer: true,
                  child: Text(
                    "Could not find any post!\n sorry! :(",
                    style: TextStyle(fontSize: 25, fontFamily: 'monospace'),
                  ),
                ),
              ),
            ),
          ],
        )
      ];
    }
    return ListView(
      children: children,
    );
  }

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppData>();

    return PageView(
      controller: appState.pageController,
      onPageChanged: (index) {
        appState.navBarIndex = index;
      },
      children: [
        buildAllPosts(context),
        JokeAddPage(),
        JokeProfileApp(),
      ],
    );
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
            onDestinationSelected: (index) {
              appState.navBarIndex = index;
              appState.pageController.jumpToPage(index);
            },
          ),
        ],
      ),
    );
  }
}
