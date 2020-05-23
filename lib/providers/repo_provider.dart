import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:github_flutter/model/repositries.dart';
import '../utils/api.dart';
import 'package:http/http.dart' as http;

class RepositriesProvider extends ChangeNotifier {
  List<Repositries> _repoList;

  List<Repositries> get repoList {
    return [..._repoList];
  }

  Future<void> getRepositriesList(String username) async {
    final link = '${Api.api}/users/${username}/repos';

    try {
      final responce = await http
          .get(link, headers: {'Authorization': 'token ${Api.token}'});
      List<Repositries> newList = [];

      final responceData = json.decode(responce.body) as List<dynamic>;

      for (int i = 0; i < responceData.length; i++) {
        Repositries repo = Repositries(
            repo_name: responceData[i]['name'],
            created_date: responceData[i]['created_at'],
            branch: responceData[i]['default_branch'],
            language: responceData[i]['language'],
            last_pushed: responceData[i]['pushed_at'],
            url: responceData[i]['html_url'],
            stars: responceData[i]['stargazers_count'],
            description: responceData[i]['description']);

        newList.add(repo);
      }

      _repoList = newList;
      _repoList.sort((a, b) => b.created_date.compareTo(a.created_date));
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
