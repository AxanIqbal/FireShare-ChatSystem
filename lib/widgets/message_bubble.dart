import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  MessageBubble({
    Key? key,
    required this.message,
    required this.isMe,
    required this.userId,
    required this.username,
    required this.uid
  }) : super(key: key);

  final String message;
  final bool isMe;
  final String userId;
  final String username;
  final String uid;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        if (isMe)
          Expanded(
            child: SizedBox(),
            flex: 6,
          ),
        Expanded(
          flex: 4,
          child: Container(
            decoration: BoxDecoration(
              color: isMe ? Theme.of(context).primaryColor : Theme.of(context).accentColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
                bottomLeft: !isMe ? Radius.circular(0) : Radius.circular(12),
                bottomRight: isMe ? Radius.circular(0) : Radius.circular(12),
              ),
            ),
            width: 140,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            child: Column(
              crossAxisAlignment:
                  !isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Text(
                    username,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isMe
                            ? Colors.black
                            : Theme.of(context)
                                .accentTextTheme
                                .headline1!
                                .color),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: SelectableText(
                    message,
                    style: TextStyle(
                        color: isMe
                            ? Colors.black
                            : Theme.of(context).accentTextTheme.headline1!.color),
                    textAlign: isMe ? TextAlign.start : TextAlign.end,
                  ),
                ),
              ],
            ),
          ),
        ),
        if (!isMe)
          Expanded(
            child: SizedBox(),
            flex: 6,
          ),
      ],
    );
  }
}
