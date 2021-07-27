import 'dart:ui';

import 'package:firesharechat/constants/firebase.dart';
import 'package:flutter/material.dart';

AppBar buildAppBar(BuildContext context) => AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      elevation: 0,
      centerTitle: false,
      title: Text("FireShare"),
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextButton(
            onPressed: () => auth.signOut(),
            child: Text(
              'Sign out',
              style: TextStyle(color: Colors.white),
            ),
            style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  vertical: 2.0,
                  horizontal: 8.0,
                ),
                minimumSize: Size(5, 5),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0))),
          ),
        )
      ],
    );
