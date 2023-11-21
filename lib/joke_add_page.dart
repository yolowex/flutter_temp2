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
  bool? checkbox1 = false;
  bool? checkbox2 = false;

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppData>();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Flexible(
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: TextField(
                controller: null,
                maxLength: 30,
                decoration: InputDecoration(
                  hintText: "Joke title",
                ),
              ),
            )),
        Flexible(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: controller,
                maxLines: 6,
                minLines: 1,
                maxLength: 250,
                decoration: const InputDecoration(
                  hintText: "Joke content",
                ),
              ),
            )),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                LayoutBuilder(
                  builder: (context, constraints) => Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      DropdownMenuGenerator(
                        width: constraints.maxWidth * 0.48,
                        hintText: "Category",
                        list: [
                          "Meme",
                          "Programmer joke",
                          "Dad joke",
                          "College Joke",
                          "Dark Humor"
                        ],
                      ),
                      SizedBox(
                        width: constraints.maxWidth * 0.04,
                      ),
                      DropdownMenuGenerator(
                        width: constraints.maxWidth * 0.48,
                        hintText: "Category",
                        list: [
                          "Meme",
                          "Programmer joke",
                          "Dad joke",
                          "College Joke",
                          "Dark Humor"
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("this content is NSFW"),
                    Checkbox(
                        value: checkbox1,
                        onChanged: (newValue) =>
                            setState(() => checkbox1 = newValue)),
                    SizedBox(
                      width: 15,
                    ),
                    Text("post is only visible\n for your followers"),
                    Checkbox(
                        value: checkbox2,
                        onChanged: (newValue) =>
                            setState(() => checkbox2 = newValue)),
                  ],
                )
              ],
            ),
          ),
        ),
        Flexible(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  onPressed: () {
                    setState(controller.clear);
                  },
                  child: Icon(Icons.cancel)),
              ElevatedButton(
                  onPressed: () {
                    appState.addJoke(
                        JokeData(accountName: "user", text: controller.text));
                    controller.clear();
                  },
                  child: Icon(Icons.done)),
            ],
          ),
        )
      ],
    );
  }
}

class DropdownMenuGenerator extends StatefulWidget {
  final List<String> list;
  final String? hintText;
  final double? width;
  const DropdownMenuGenerator(
      {super.key, required this.list, this.hintText, this.width});

  @override
  State<DropdownMenuGenerator> createState() => _DropdownMenuGeneratorState();
}

class _DropdownMenuGeneratorState extends State<DropdownMenuGenerator> {
  late String dropdownValue = widget.list.first;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: DropdownMenu(
        width: widget.width,
        initialSelection: widget.list.first,
        label: widget.hintText == null ? null : Text(widget.hintText!),
        onSelected: (String? value) {
          setState(() {
            dropdownValue = value!;
          });
        },
        dropdownMenuEntries: widget.list.map((String value) {
          return DropdownMenuEntry(value: value, label: value);
        }).toList(),
      ),
    );
  }
}
