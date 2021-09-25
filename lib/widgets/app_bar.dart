import 'dart:ui';

import 'package:fireshare/constants/firebase.dart';
import 'package:flutter/material.dart';

AppBar buildAppBar(BuildContext context, String title, String? picture) {
  return AppBar(
    backgroundColor: Theme.of(context).primaryColor,
    elevation: 0,
    centerTitle: false,
    title: Row(
      children: [
        if (picture != null)
          CircleAvatar(
            radius: 20,
            // backgroundImage: NetworkImage(picture),
            child: ClipOval(
              child: Image.network(
                picture,
              ),
            ),
          ),
        const SizedBox(
          width: 10,
        ),
        Text(title),
      ],
    ),
    actions: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextButton(
          onPressed: () => auth.signOut(),
          child: const Text(
            'Sign out',
            style: TextStyle(color: Colors.white),
          ),
          style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                vertical: 2.0,
                horizontal: 8.0,
              ),
              minimumSize: const Size(5, 5),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0))),
        ),
      )
    ],
  );
}
