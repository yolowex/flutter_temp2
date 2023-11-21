import 'package:flutter/material.dart';

enum LikeState { liked, disliked, none }

class JokeData {
  final String accountName;
  final String title;
  final String text;
  final bool isNSFW;
  final bool isPrivate;
  final String? category1;
  final String? category2;

  LikeState likeState = LikeState.none;
  JokeData(
      {required this.accountName,
      required this.text,
      required this.title,
      this.isNSFW = false,
      this.isPrivate = false,
      required this.category1,
      required this.category2});
}

class JokeView extends StatefulWidget {
  final JokeData jokeData;

  JokeView(this.jokeData);

  @override
  State<JokeView> createState() => _JokeViewState();
}

class _JokeViewState extends State<JokeView> {
  bool isExpanded = false;
  void onExpand() {
    setState(() => isExpanded = !isExpanded);
  }

  void onLike() {
    setState(() {
      if (widget.jokeData.likeState == LikeState.liked) {
        widget.jokeData.likeState = LikeState.none;
      } else {
        widget.jokeData.likeState = LikeState.liked;
      }
    });
  }

  void onDislike() {
    setState(() {
      if (widget.jokeData.likeState == LikeState.disliked) {
        widget.jokeData.likeState = LikeState.none;
      } else {
        widget.jokeData.likeState = LikeState.disliked;
      }
    });
  }

  Widget buildTagCard(String text){
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Text(text),
      )
    );
  }

  List<Widget> getTagCards(){
    List<Widget> list = [];

    if (widget.jokeData.isNSFW){
      list.add(buildTagCard("nsfw"));
    }

    if (widget.jokeData.isPrivate){
      list.add(buildTagCard("private"));
    }

    list.add(buildTagCard(widget.jokeData.category1!));
    list.add(buildTagCard(widget.jokeData.category2!));

    return list;
  }


  @override
  Widget build(BuildContext context) {
    var limit = 30;
    if (widget.jokeData.text.length <= limit) {
      limit = widget.jokeData.text.length - 1;
    }

    var style0 = TextStyle(fontSize: 50);
    var style1 = TextStyle(fontSize: 25);
    var style2 = TextStyle(fontSize: 35, fontWeight: FontWeight.bold);

    return Container(
      decoration: BoxDecoration(
          color: Colors.blue.shade500,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: Colors.red.shade900, width: 5)),
      child: Column(
        textBaseline: TextBaseline.alphabetic,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(Icons.account_circle_outlined, size: 50),
              Text(
                widget.jokeData.accountName,
                style: style0,
              )
            ],
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(widget.jokeData.title,
                maxLines: isExpanded ? null : 3,
                overflow: TextOverflow.fade,
                style: style2),
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(widget.jokeData.text,
                maxLines: isExpanded ? null : 3,
                overflow: TextOverflow.fade,
                style: style1),
          ),
          SizedBox(
            height: 15,
          ),
          Wrap(
            alignment: WrapAlignment.end,
            direction: Axis.horizontal,
              children: getTagCards(),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                  onPressed: onLike,
                  icon: Icon(widget.jokeData.likeState == LikeState.liked
                      ? Icons.thumb_up
                      : Icons.thumb_up_alt_outlined)),
              IconButton(
                  onPressed: onDislike,
                  icon: Icon(widget.jokeData.likeState == LikeState.disliked
                      ? Icons.thumb_down
                      : Icons.thumb_down_alt_outlined)),
              IconButton(
                  onPressed: onExpand,
                  icon:
                      Icon(isExpanded ? Icons.expand_less : Icons.expand_more)),
            ],
          ),
        ],
      ),
    );
  }
}
