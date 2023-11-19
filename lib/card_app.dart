import 'package:flutter/material.dart';

class CardApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
          body: ListView(children: [
        Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(width: double.infinity),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: BusinessCard(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: BusinessCard(name: 'Sorush',title: 'Bakset kojast?',),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: BusinessCard(name: 'Soroooosh!',title: 'Begoo bishtar bian...',),
            )
          ],
        ),
      ])),
    );
  }
}

class BusinessCard extends StatefulWidget {
  String? name;
  String? title;
  String? address;
  String? number;

  BusinessCard({String? name, String? title, String? address, String? number}) {
    this.name = name ?? 'Nobody';
    this.title = title ?? 'Mr Chester';
    this.address = address ?? 'kooche ali chap';
    this.number = number ?? '123 456 789';
  }

  @override
  State<BusinessCard> createState() => _BusinessCardState();
}

class _BusinessCardState extends State<BusinessCard> {
  var boldStyle = TextStyle(
      fontSize: 25, fontFamily: 'monospace', fontWeight: FontWeight.bold);

  var style = TextStyle(fontSize: 20, fontFamily: 'monospace');

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500,
      height: 220,
      color: Colors.lightBlue,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(Icons.account_circle, size: 65),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(widget.name!, style: boldStyle),
                  Text(widget.title!, style: style)
                ],
              )
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(widget.address!, style: style),
              Text(widget.number!, style: style),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(size: 45, Icons.accessibility),
              Icon(size: 45, Icons.punch_clock),
              Icon(size: 45, Icons.phone),
              Icon(size: 45, Icons.android),
            ],
          ),
        ],
      ),
    );
  }
}
