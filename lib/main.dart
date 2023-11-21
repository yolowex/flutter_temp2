import 'package:flutter/material.dart';
import 'package:layout_concepts/bad_boy_puzzle.dart';
import 'package:layout_concepts/card_app.dart';
import 'package:layout_concepts/joke_app.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData.dark(),
    home: JokeApp(),
  ));
}
