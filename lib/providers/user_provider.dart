import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:github_flutter/model/user.dart';
import '../utils/api.dart';
import 'package:http/http.dart' as http;

class UserProvider with ChangeNotifier {
  User user;

  Future<void> getUserProfile(String username) async {
    final url = '${Api.api}/users/${username}';

    try {
      final responce =
          await http.get(url, headers: {'Authorization': 'token ${Api.token}'});

      final responceData = json.decode(responce.body) as Map<String, dynamic>;

      print(responceData['name']);

      user = User(
        username: responceData['login'],
        imageUrl: responceData['avatar_url'],
        followers: responceData['followers'],
        followings: responceData['following'],
        public_repo: responceData['public_repos'],
        joined_date: responceData['created_at'],
      );

      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
