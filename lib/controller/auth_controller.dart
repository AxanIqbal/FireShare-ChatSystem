import 'package:fireshare/models/user_profile.dart';
import 'package:fireshare/screens/auth_screen.dart';
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
      Get.offAll(() => const AuthScreen());
    } else {
      firebaseFirestore
          .collection('users')
          .doc(user.uid)
          .withConverter<UserProfile>(
              fromFirestore: (snapshots, _) =>
                  UserProfile.fromJson(snapshots.data()!),
              toFirestore: (message, _) => message.toJson())
          .get()
          .then((value) => userProfile = value.data());
    }
  }
}
