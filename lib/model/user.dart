import 'dart:convert';

import 'package:github_flutter/mixins/json_parser.dart';

class User {
  String? name;
  String? username;
  String? bio;
  String? imageUrl;
  int? followers;
  int? followings;
  int? publicRepo;
  String? joinedDate;

  User({
    this.bio,
    this.name,
    this.username,
    this.imageUrl,
    this.joinedDate,
    this.followers,
    this.followings,
    this.publicRepo,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'login': username,
      'avatar_url': imageUrl,
      'followers': followers,
      'following': followings,
      'public_repos': publicRepo,
      'created_at': joinedDate,
      'bio': bio
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: JsonParser.toStringorEmpty(map['name']),
      bio: JsonParser.toStringorEmpty(map['bio']),
      username: JsonParser.toStringorEmpty(map['login']),
      imageUrl: JsonParser.toStringorEmpty(map['avatar_url']),
      followers: JsonParser.toIntOrZero(map['followers']),
      followings: JsonParser.toIntOrZero(map['following']),
      publicRepo: JsonParser.toIntOrZero(map['public_repos']),
      joinedDate: JsonParser.toStringorEmpty(map['created_at']),
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}
