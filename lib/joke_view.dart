import 'package:flutter/material.dart';

enum LikeState { liked, disliked, none }

class JokeData {
  final String accountName;
  final String text;
  LikeState likeState = LikeState.none;
  JokeData({required this.accountName, required this.text});
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

  @override
  Widget build(BuildContext context) {
    var limit = 30;
    if (widget.jokeData.text.length <= limit) {
      limit = widget.jokeData.text.length - 1;
    }

    var style0 = TextStyle(fontSize: 50);
    var style1 = TextStyle(fontSize: 25);

    return Container(
      decoration: BoxDecoration(
          color: Colors.blue.shade500,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: Colors.red.shade900, width: 5)),
      child: Column(
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
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text(widget.jokeData.text,
                      maxLines: isExpanded ? null : 3,
                      overflow: TextOverflow.fade,
                      style: style1),
                ),
              )
            ],
          ),
          SizedBox(
            height: 15,
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
