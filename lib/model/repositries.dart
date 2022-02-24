import 'dart:convert';

import 'package:github_flutter/mixins/json_parser.dart';

class Repositries {
  final String? repoName;
  final String? createdDate;
  final String? lastPushed;
  final String? description;
  final String? branch;
  final String? language;
  final String? url;
  final int? stars;
  final int? forks;

  Repositries(
      {this.repoName,
      this.createdDate,
      this.branch,
      this.description,
      this.language,
      this.lastPushed,
      this.stars,
      this.url,
      this.forks});

  Map<String, dynamic> toMap() {
    return {
      'name': repoName,
      'created_at': createdDate,
      'pushed_at': lastPushed,
      'description': description,
      'default_branch': branch,
      'language': language,
      'html_url': url,
      'stargazers_count': stars,
      'forks_count': forks
    };
  }

  factory Repositries.fromMap(Map<String, dynamic> map) {
    return Repositries(
        repoName: JsonParser.toStringorEmpty(map['name']),
        createdDate: JsonParser.toStringorEmpty(map['created_at']),
        lastPushed: JsonParser.toStringorEmpty(map['pushed_at']),
        description: JsonParser.toStringorEmpty(map['description']),
        branch: JsonParser.toStringorEmpty(map['default_branch']),
        language: JsonParser.toStringorEmpty(map['language']),
        url: JsonParser.toStringorEmpty(map['html_url']),
        stars: JsonParser.toIntOrZero(map['stargazers_count']),
        forks: JsonParser.toIntOrZero(map['forks_count']));
  }

  String toJson() => json.encode(toMap());

  factory Repositries.fromJson(String source) =>
      Repositries.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Repositries(repoName: $repoName, createdDate: $createdDate, lastPushed: $lastPushed, description: $description, branch: $branch, language: $language, url: $url, stars: $stars)';
  }
}
