import 'package:flutter/material.dart';
import 'package:layout_concepts/joke_app.dart';
import 'package:layout_concepts/joke_view.dart';
import 'package:provider/provider.dart';

class JokeAddPage extends StatefulWidget {
  @override
  State<JokeAddPage> createState() => _JokeAddPageState();
}

class _JokeAddPageState extends State<JokeAddPage> {
  TextEditingController textController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  FocusNode textFocusNode = FocusNode();
  FocusNode titleFocusNode = FocusNode();

  bool? isNSFW = false;
  bool? isPrivate = false;

  String? dropDown1Value;
  String? dropDown2Value;

  @override
  void initState() {
    // TODO: implement initState
    textFocusNode.addListener(() {
      setState((){});
    });

    titleFocusNode.addListener(() {
      setState(() {});
    });

    super.initState();
  }


  @override
  void dispose() {
    // TODO: implement dispose
    textFocusNode.dispose();
    titleFocusNode.dispose();
    super.dispose();
  }
  bool canSubmit() {
    return titleController.text.isNotEmpty && textController.text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {

    var appState = context.watch<AppData>();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        LayoutBuilder(
          builder: (context, constraints) => Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
              width: constraints.maxWidth * 0.5,
              child: TextField(

                focusNode: titleFocusNode,
                controller: titleController,
                maxLength: 30,
                decoration: const InputDecoration(
                  hintText: "Joke title",
                  border: UnderlineInputBorder(),
                ),
              ),
            ),
          ),
        ),
        Flexible(
            child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextField(
            focusNode: textFocusNode,
            controller: textController,
            maxLines: 6,
            minLines: 1,
            maxLength: 250,
            decoration: const InputDecoration(
              hintText: "Joke content",
              border: OutlineInputBorder(),
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
                        onSelected: (newValue) {
                          dropDown1Value = newValue;
                        },
                        hintText: "Category",
                        width: constraints.maxWidth * 0.48,
                        list: [
                          "Meme",
                          "Programmer joke",
                          "College Joke",
                        ],
                      ),
                      SizedBox(
                        width: constraints.maxWidth * 0.04,
                      ),
                      DropdownMenuGenerator(
                        onSelected: (newValue) {
                          dropDown2Value = newValue;
                        },
                        hintText: "Genre",
                        width: constraints.maxWidth * 0.48,
                        list: [
                          "Fun",
                          "Dark Humor",
                          "Dad Joke",
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("this content is NSFW"),
                    Checkbox(
                        value: isNSFW,
                        onChanged: (newValue) =>
                            setState(() => isNSFW = newValue)),
                    const SizedBox(
                      width: 5,
                    ),
                    const Text("post is only visible\n for your followers"),
                    Checkbox(
                        value: isPrivate,
                        onChanged: (newValue) =>
                            setState(() => isPrivate = newValue)),
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
                    setState(() {
                      titleController.clear();
                      textController.clear();
                    });
                  },
                  child: Icon(Icons.cancel)),
              ElevatedButton(
                  onPressed: canSubmit()
                      ? () {
                          JokeData jokeData = JokeData(
                              title: titleController.text,
                              accountName: "user",
                              text: textController.text,
                              isNSFW: isNSFW == null ? false : isNSFW!,
                              isPrivate: isPrivate == null ? false : isPrivate!,
                              category1: dropDown1Value,
                              category2: dropDown2Value);

                          appState.addJoke(
                            jokeData,
                          );
                          titleController.clear();
                          textController.clear();
                        }
                      : null,
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
  late String dropdownValue = list.first;
  final void Function(String?) onSelected;

  DropdownMenuGenerator(
      {super.key,
      required this.list,
      this.hintText,
      this.width,
      required this.onSelected}) {
    onSelected(dropdownValue);
  }

  @override
  State<DropdownMenuGenerator> createState() => _DropdownMenuGeneratorState();
}

class _DropdownMenuGeneratorState extends State<DropdownMenuGenerator> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: DropdownMenu(
        width: widget.width,
        initialSelection: widget.list.first,
        label: widget.hintText == null ? null : Text(widget.hintText!),
        onSelected: (String? value) {
          setState(() {
            print('selected');
            widget.dropdownValue = value!;
            widget.onSelected(widget.dropdownValue);
          });
        },
        dropdownMenuEntries: widget.list.map((String value) {
          return DropdownMenuEntry(value: value, label: value);
        }).toList(),
      ),
    );
  }
}
