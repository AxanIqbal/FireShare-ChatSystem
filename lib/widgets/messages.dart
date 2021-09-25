import 'package:fireshare/constants/firebase.dart';
import 'package:fireshare/controller/message_controller.dart';
import 'package:fireshare/widgets/message_bubble.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Messages extends StatelessWidget {
  const Messages({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MessageController _controller = Get.find();
    final _data = _controller.messages;
    return Obx(
      () => _data.value.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              reverse: true,
              itemCount: _data.value.length,
              itemBuilder: (context, index) => Container(
                padding: const EdgeInsets.all(8),
                child: MessageBubble(
                  message: _data.value[index].text,
                  isMe: _data.value[index].userId == auth.currentUser!.uid,
                  // key: ValueKey(_data.value![index].id),
                  userId: _data.value[index].userId,
                  username: _data.value[index].username,
                  uid: _data.value[index].uid
                ),
              ),
            ),
    );
    // return StreamBuilder<QuerySnapshot>(
    //   stream: FirebaseFirestore.instance
    //       .collection('chats/zDcElQHuGNRDqVmiOA0w/messages')
    //       .orderBy('createdAt', descending: true)
    //       .snapshots(),
    //   builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
    //     if (snapshot.hasError) {
    //       return Text('Something went wrong');
    //     }
    //     if (snapshot.connectionState == ConnectionState.waiting) {
    //       return Center(child: CircularProgressIndicator());
    //     }
    //     final documents = snapshot.data!.docs;
    //     return ListView.builder(
    //       reverse: true,
    //       itemCount: (snapshot.data!).docs.length,
    //       itemBuilder: (context, index) => Container(
    //         padding: const EdgeInsets.all(8),
    //         child: MessageBubble(
    //           message: documents[index]['Text'],
    //           isMe: documents[index]['UserId'] == auth.currentUser!.uid,
    //           key: ValueKey(documents[index].id),
    //           userId: documents[index]['UserId'],
    //           username: documents[index]['username'],
    //         ),
    //       ),
    //     );
    //   },
    // );
  }
}
