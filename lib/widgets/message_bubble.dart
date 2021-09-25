import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble(
      {Key? key,
      required this.message,
      required this.isMe,
      required this.userId,
      required this.username,
      required this.uid})
      : super(key: key);

  final String message;
  final bool isMe;
  final String userId;
  final String username;
  final String uid;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        // showMenu(context: context, position: [], items: items)
      },
      child: Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (isMe)
            const Expanded(
              child: SizedBox(),
              flex: 4,
            ),
          Expanded(
            flex: 4,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: isMe
                        ? Theme.of(context).primaryColor
                        : Color(Theme.of(context).primaryColor.value - 30),
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(12),
                      topRight: const Radius.circular(12),
                      bottomLeft: !isMe
                          ? const Radius.circular(0)
                          : const Radius.circular(12),
                      bottomRight: isMe
                          ? const Radius.circular(0)
                          : const Radius.circular(12),
                    ),
                  ),
                  // width: 140,
                  width: double.infinity,
                  padding:
                     const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  margin:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  child: Column(
                    crossAxisAlignment: !isMe
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
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
                                  : Theme.of(context)
                                      .accentTextTheme
                                      .headline1!
                                      .color),
                          textAlign: isMe ? TextAlign.start : TextAlign.end,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: isMe ? -18 : null,
                  right: isMe ? null : -18,
                  top: -10,
                  child: const CircleAvatar(),
                ),
              ],
            ),
          ),
          if (!isMe)
            const Expanded(
              child: SizedBox(),
              flex: 4,
            ),
        ],
      ),
    );
  }
}
