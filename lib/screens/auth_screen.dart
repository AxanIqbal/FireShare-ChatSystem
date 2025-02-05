import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fireshare/constants/firebase.dart';
import 'package:fireshare/controller/auth_controller.dart';
import 'package:fireshare/models/user_profile.dart';
import 'package:fireshare/picker/user_image_picker.dart';
import 'package:fireshare/screens/messenger_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

import 'chat_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final UserController c = Get.find();

  @override
  void initState() {
    if (c.userProfile != null) {
      Get.offAll(const MessengerScreen());
    }
    super.initState();
  }

  final _formKey = GlobalKey<FormBuilderState>();
  var _isLogIn = true;
  var _isLoading = false;
  File? pickedImage;

  void imagePickFunc(File? file) {
    pickedImage = file;
  }

  // uploadImageToStorage() async {
  //   if (kIsWeb) {
  //     Reference _reference = FirebaseStorage.instance
  //         .ref()
  //         .child('user_image/${authResult.user!.uid}');
  //     await _reference
  //         .putData(
  //       await pickedImage!.readAsBytes(),
  //       SettableMetadata(contentType: 'image/jpeg'),
  //     )
  //         .whenComplete(() async {
  //       await _reference.getDownloadURL().then((value) {
  //         var uploadedPhotoUrl = value;
  //       });
  //     });
  //   } else {
  //     //write a code for android or ios

  //   }
  // }

  void _formHandler(String email, String username, String password,
      String confirmPassword) async {
    if (password != confirmPassword) {
      return null;
    }
    UserCredential authResult;
    try {
      setState(() {
        _isLoading = true;
      });
      if (_isLogIn) {
        authResult = await auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        if (pickedImage == null) {
          setState(() {
            _isLoading = false;
          });
          return Get.snackbar('Error', "Please add an Image");
        }

        authResult = await auth.createUserWithEmailAndPassword(
            email: email, password: password);

        // final ref = FirebaseStorage.instance
        //     .ref()
        //     .child('user_image')
        //     .child(authResult.user!.uid + '.jpg');
        // print("Adding picture to the storage ${pickedImage!.path}");
        // await ref.putFile(await urlToFile(pickedImage!.path)).whenComplete(() {
        //   Get.snackbar('Success', 'Done Uploading');
        //   print("Done uploading");
        // });
        await firebaseFirestore
            .collection('users')
            .doc(authResult.user!.uid)
            .set(UserProfile(
                email: email,
                username: username,
                friends: [],
                blocked: []).toJson())
            .catchError((e) => Get.snackbar('Error', e));

        Reference _reference = FirebaseStorage.instance
            .ref()
            .child('user_image/${authResult.user!.uid}');
        if (kIsWeb) {
          await _reference
              .putData(
            await pickedImage!.readAsBytes(),
            SettableMetadata(contentType: 'image/jpeg'),
          )
              .whenComplete(() async {
            await _reference.getDownloadURL().then((value) async {
              await authResult.user!.updatePhotoURL(value);
            });
          });
        } else {
          //write a code for android or ios

          await _reference.putFile(pickedImage!).whenComplete(() async {
            await _reference.getDownloadURL().then((value) async {
              await authResult.user!.updatePhotoURL(value);
            });
          });
        }
      }
      Get.offAll(() => const MessengerScreen());
    } on FirebaseAuthException catch (e) {
      var message = 'An error occurred, please check your credentials!';

      if (e.message != null) {
        message = e.message!;
      }
      Get.snackbar("Error", message);
      setState(() {
        _isLoading = false;
      });
      // Theme.of(context).snackBarTheme
    } catch (err) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Row(
          children: [
            const Expanded(flex: 1, child: SizedBox()),
            Expanded(
              flex: 5,
              child: Card(
                margin: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: FormBuilder(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          if (!_isLogIn)
                            UserImagePicker(
                              imagePickFunc: imagePickFunc,
                            ),
                          FormBuilderTextField(
                            name: 'email',
                            keyboardType: TextInputType.emailAddress,
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(context),
                              FormBuilderValidators.email(context,
                                  errorText:
                                      'Please Enter a valid email address')
                            ]),
                            decoration:
                                const InputDecoration(labelText: 'Email'),
                          ),
                          if (!_isLogIn)
                            FormBuilderTextField(
                              name: 'username',
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(context),
                                FormBuilderValidators.minLength(context, 3),
                              ]),
                              decoration:
                                  const InputDecoration(labelText: 'Username'),
                            ),
                          FormBuilderTextField(
                            name: 'password',
                            obscureText: true,
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(context),
                              FormBuilderValidators.minLength(context, 6)
                            ]),
                            decoration:
                                const InputDecoration(labelText: 'Password'),
                          ),
                          if (!_isLogIn)
                            FormBuilderTextField(
                              name: 'confirm_password',
                              obscureText: true,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(context),
                                (val) {
                                  if (val !=
                                      _formKey.currentState?.fields['password']
                                          ?.value) {
                                    return 'Passwords do not match';
                                  }
                                  return null;
                                }
                              ]),
                              decoration: const InputDecoration(
                                  labelText: 'Confirm Password'),
                            ),
                          const SizedBox(
                            height: 12,
                          ),
                          if (_isLoading) const CircularProgressIndicator(),
                          if (!_isLoading)
                            MaterialButton(
                              onPressed: () {
                                if (_formKey.currentState?.saveAndValidate() ??
                                    false) {
                                  final values = _formKey.currentState?.value;
                                  if (_isLogIn) {
                                    _formHandler(
                                        values!['email'],
                                        values['email'],
                                        values['password'],
                                        values['password']);
                                  } else {
                                    _formHandler(
                                        values!['email'],
                                        values['username'],
                                        values['password'],
                                        values['confirm_password']);
                                  }
                                }
                              },
                              child: Text(_isLogIn ? 'Login' : 'SignUp'),
                              color: Theme.of(context).primaryColor,
                            ),
                          if (!_isLoading)
                            TextButton(
                                onPressed: () {
                                  setState(() {
                                    _isLogIn = !_isLogIn;
                                  });
                                },
                                child: Text(
                                  !_isLogIn
                                      ? 'Already have account?'
                                      : 'Create new account',
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor),
                                ))
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const Expanded(flex: 1, child: SizedBox()),
          ],
        ),
      ),
    );
  }
}
