import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firesharechat/constants/firebase.dart';
import 'package:firesharechat/controller/authController.dart';
import 'package:firesharechat/models/message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MessageController extends GetxController {
  MessageController({required this.collection});

  String collection;
  var entredmessage = ''.obs;
  Rx<List<Message>> messages = Rx<List<Message>>([]);
  late final CollectionReference<Message> collectionRef;
  final UserController user = Get.find();
  final controller = new TextEditingController();

  @override
  void onInit() {
    super.onInit();
    collectionRef = firebaseFirestore
        .collection('chats')
        .doc(collection)
        .collection('messages')
        .withConverter<Message>(
            fromFirestore: (snapshots, _) =>
                Message.fromJson({...snapshots.data()!,"uid": ""}),
            toFirestore: (message, _) => message.toJson());
  }

  @override
  void onReady() {
    super.onReady();
    messages.bindStream(_getMessageData());
  }

  Stream<List<Message>> _getMessageData() {
    // List<Message> messageList = [];
    return collectionRef
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((QuerySnapshot<Message> ds) {
      List<Message> messageList = [];
      List<String> uid = [];
      ds.docs.forEach((QueryDocumentSnapshot<Message> element) {
        messageList.add(element.data());
        uid.add(element.id);
      });
      for (var i = 0; i < messageList.length; i++) {
        messageList[i].uid = uid[i];
      }
      return messageList;
    });
  }

  setEntredMessage(String text) {
    entredmessage = RxString(text);
  }

  sendMessage() {
    return collectionRef
        .add(Message(
          text: entredmessage.value,
          userId: auth.currentUser!.uid,
          username: user.userProfile!.username,
          createdAt: Timestamp.now(),
          uid: "",
        ))
        .then((_) => controller.text = '');
  }
}
