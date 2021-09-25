import 'package:fireshare/controller/messanger_controller.dart';
import 'package:fireshare/screens/chat_screen.dart';
import 'package:fireshare/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MessengerScreen extends StatelessWidget {
  const MessengerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(MessengerController());
    final MessengerController _controller = Get.find();
    return Scaffold(
      appBar: buildAppBar(context, "Messenger", null),
      body: Obx(
        () => ListView.builder(
          itemBuilder: (context, index) => ListTile(
            onTap: () => Get.to(() => ChatScreen(
                  collection: _controller.messages.value[index],
                )),
            title: Text(_controller.messages.value[index].name),
            leading: const CircleAvatar(),
          ),
          itemCount: _controller.messages.value.length,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
