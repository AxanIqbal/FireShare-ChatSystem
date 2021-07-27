import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

Message messageFromJson(String str) => Message.fromJson(json.decode(str));

String messageToJson(Message data) => json.encode(data.toJson());

class Message {
  Message({
    required this.text,
    required this.userId,
    required this.username,
    required this.createdAt,
    required this.uid,
  });

  String text;
  String userId;
  String username;
  Timestamp createdAt;
  String uid;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        text: json["Text"],
        userId: json["UserId"],
        username: json["username"],
        createdAt: json["createdAt"],
        uid: json["uid"],
      );

  Map<String, dynamic> toJson() => {
        "Text": text,
        "UserId": userId,
        "username": username,
        "createdAt": createdAt,
      };
}
