import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

Messenger messengerFromJson(String str) => Messenger.fromJson(json.decode(str));

String messengerToJson(Messenger data) => json.encode(data.toJson());

class Messenger {
  Messenger({
    required this.admin,
    required this.name,
    required this.users,
    required this.uid,
    required this.createdAt,
    required this.updatedAt,
  });

  String admin;
  String name;
  List<String> users;
  String uid;
  Timestamp createdAt;
  Timestamp updatedAt;

  factory Messenger.fromJson(DocumentSnapshot<Map<String, dynamic>> json) =>
      Messenger(
        admin: json.data()!["admin"],
        name: json.data()!["name"],
        uid: json.id,
        createdAt: json.data()!['createdAt'],
        updatedAt: json.data()!['updatedAt'],
        users: List<String>.from(json.data()!["users"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "admin": admin,
        "name": name,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "users": List<dynamic>.from(users.map((x) => x)),
      };
}
