import 'package:firesharechat/controller/messageController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewMessage extends StatelessWidget {
  const NewMessage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MessageController c = Get.find();

    return Container(
        margin: EdgeInsets.only(top: 8),
        padding: EdgeInsets.all(8),
        child: GetX<MessageController>(
          init: c,
          builder: (controller) => Row(
            children: [
              Expanded(
                child: TextField(
                  autocorrect: true,
                  decoration: InputDecoration(
                      labelText: "Send a message...",
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide.none,
                      )),
                  onChanged: controller.setEntredMessage,
                  controller: c.controller,
                ),
              ),
              IconButton(
                onPressed: controller.entredmessage.value.trim().isNotEmpty
                    ? null
                    : c.sendMessage,
                icon: Icon(Icons.send),
                color: Theme.of(context).primaryColor,
              ),
            ],
          ),
        ));
  }
}
