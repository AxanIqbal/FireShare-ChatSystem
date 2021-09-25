import 'package:fireshare/controller/auth_controller.dart';
import 'package:fireshare/controller/message_controller.dart';
import 'package:fireshare/models/messanger.dart';
import 'package:fireshare/widgets/messages.dart';
import 'package:fireshare/widgets/newmessage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({
    Key? key,
    required this.collection,
  }) : super(key: key);
  final Messenger collection;

  @override
  Widget build(BuildContext context) {
    Get.put(MessageController(collection: collection.uid));
    final UserController c = Get.find();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: false,
        title: Row(
          children: [
            const CircleAvatar(),
            const SizedBox(
              width: 10,
            ),
            Text(collection.name)
          ],
        ),
        actions: [
          if (collection.admin == c.firebaseUser.value!.uid)
            TextButton(
              onPressed: () {},
              child: const Text('Add User'),
            ),
          TextButton(onPressed: () {
            
          }, child: const Text('Leave'))
        ],
      ),
      body: Column(
        children: const [
          Expanded(child: Messages()),
          NewMessage(),
        ],
      ),
    );
  }
}
