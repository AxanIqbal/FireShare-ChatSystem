import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firesharechat/models/userProfile.dart';
import 'package:firesharechat/screens/auth_screen.dart';
import 'package:firesharechat/screens/chat_screen.dart';
import 'package:get/get.dart';
import '../constants/firebase.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserController extends GetxController {
  static UserController instance = Get.find();

  Rxn<User> firebaseUser = Rxn<User>();
  UserProfile? userProfile;
  RxBool isLoggedIn = false.obs;

  @override
  void onReady() {
    super.onReady();
    firebaseUser = Rxn<User>(auth.currentUser);
    firebaseUser.bindStream(auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    if (user == null) {
      userProfile = null;
      Get.offAll(() => AuthScreen());
    } else {
      firebaseFirestore.collection('users').doc(user.uid).withConverter<UserProfile>(
          fromFirestore: (snapshots, _) =>
              UserProfile.fromJson(snapshots.data()!),
          toFirestore: (message, _) => message.toJson()).get().then((value) => userProfile = value.data());
      Get.offAll(() => ChatScreen());
    }
  }
}
