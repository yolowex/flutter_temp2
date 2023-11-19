import 'package:flutter/material.dart';
import 'package:layout_concepts/joke_app.dart';
import 'package:layout_concepts/joke_view.dart';
import 'package:provider/provider.dart';

class JokeAddPage extends StatefulWidget {
  @override
  State<JokeAddPage> createState() => _JokeAddPageState();
}

class _JokeAddPageState extends State<JokeAddPage> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppData>();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
            child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextField(
            controller: controller,
            maxLines: 6,
            minLines: 1,
            decoration: InputDecoration(
              hintText: "Input your joke here!",
            ),
          ),
        )),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(onPressed: () {
              setState(
                controller.clear
              );
            }, child: Icon(Icons.cancel)),
            ElevatedButton(onPressed: () {
              appState.addJoke(JokeData(accountName: "user", text: controller.text));
              controller.clear();
            }, child: Icon(Icons.done)),
          ],
        )
      ],
    );
  }
}
