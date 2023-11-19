import 'dart:math';
import 'package:flutter/material.dart';

class BadBoyPuzzle extends StatelessWidget {
  const BadBoyPuzzle({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.dark,
          seedColor: Colors.deepPurple,
        ),
        useMaterial3: true,
      ),
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void onUpdate(String newText) {
    setState(() {
      initialText = newText;
    });
  }

  late String initialText = "1";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 400,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Initial text: ${initialText}'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    initialText = Random().nextInt(100).toString();
                  });
                },
                child: const Text('Change initial text'),
              ),
              const SizedBox(height: 16),
              SomeTextInput(text: initialText,onUpdate: onUpdate),
            ],
          ),
        ),
      ),
    );
  }
}

class SomeTextInput extends StatefulWidget {
  const SomeTextInput({super.key, required this.text,required this.onUpdate});

  final String text;
  final Function onUpdate;

  @override
  State<SomeTextInput> createState() => _SomeTextInputState();
}

class _SomeTextInputState extends State<SomeTextInput> {
  late final TextEditingController _controller = TextEditingController(
    text: widget.text,
  );

  @override
  void didUpdateWidget(covariant SomeTextInput oldWidget) {
    // TODO: implement didUpdateWidget
    // if (oldWidget.textHolder.text != widget.textHolder.text) {

    _controller.text = widget.text;
    // }

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      onSubmitted: (text) {
        widget.onUpdate(text);
      },
      decoration: const InputDecoration(
        labelText: 'Some text',
        border: OutlineInputBorder(),
      ),
    );
  }
}
