import 'package:firesharechat/controller/messageController.dart';
import 'package:firesharechat/screens/app_bar.dart';
import 'package:firesharechat/widgets/messages.dart';
import 'package:firesharechat/widgets/newmessage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(MessageController(collection: "zDcElQHuGNRDqVmiOA0w"));
    return Scaffold(
      appBar: buildAppBar(context),
      body: Container(
          child: Column(
        children: [
          Expanded(child: Messages()),
          NewMessage(),
        ],
      )),
    );
  }
}
