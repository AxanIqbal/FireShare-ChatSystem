import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fireshare/constants/firebase.dart';
import 'package:fireshare/models/messanger.dart';
import 'package:get/get.dart';

class MessengerController extends GetxController {
  static MessengerController instance = Get.find();
  Rx<List<Messenger>> messages = Rx<List<Messenger>>([]);
  Rxn<User> firebaseUser = Rxn<User>();
  CollectionReference<Messenger> collectionRef = firebaseFirestore
      .collection('chats')
      .withConverter<Messenger>(
          fromFirestore: (snapshots, _) => Messenger.fromJson(snapshots),
          toFirestore: (message, _) => message.toJson());

  @override
  void onReady() {
    firebaseUser = Rxn<User>(auth.currentUser);
    messages.bindStream(_getMessenger());
    super.onReady();
  }

  Stream<List<Messenger>> _getMessenger() {
    return collectionRef
        .where('users', arrayContains: firebaseUser.value!.uid)
        .snapshots()
        .map((event) {
      List<Messenger> tempMessenger = [];
      for (var element in event.docs) {
        tempMessenger.add(element.data());
      }
      return tempMessenger;
    });
  }

  newChat(String name, String user) {
    collectionRef.add(Messenger(
      admin: firebaseUser.value!.uid,
      name: name,
      users: [firebaseUser.value!.uid, user],
      uid: '',
      createdAt: Timestamp.now(),
      updatedAt: Timestamp.now(),
    ));
  }
}
