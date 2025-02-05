import 'dart:convert';

UserProfile userProfileFromJson(String str) => UserProfile.fromJson(json.decode(str));

String userProfileToJson(UserProfile data) => json.encode(data.toJson());

class UserProfile {
  UserProfile({
    required this.email,
    required this.username,
    required this.friends,
    required this.blocked,
  });

  String email;
  String username;
  List<String> friends;
  List<String> blocked;

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
    email: json["email"],
    username: json["username"],
    friends: List<String>.from(json["friends"].map((x) => x)),
    blocked: List<String>.from(json["blocked"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "username": username,
    "friends": List<dynamic>.from(friends.map((x) => x)),
    "blocked": List<dynamic>.from(blocked.map((x) => x)),
  };
}