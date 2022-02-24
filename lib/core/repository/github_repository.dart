import 'package:github_flutter/constants/enums.dart';
import 'package:github_flutter/core/service/github_service.dart';
import 'package:github_flutter/model/repositries.dart';
import 'package:github_flutter/model/user.dart';

class GithubRepository {
  final _githubService = GithubService();

  Future<List<Repositries>> getuserRepositriesList(String? username) =>
      _githubService.getuserRepositriesList(username);

  Future<User> getUserProfile(String? username) =>
      _githubService.getUserProfile(username);

  Future<List<User>> getActionUserList(
          String? username, ActionUserListType actionUserListType) =>
      _githubService.getActionUserList(username, actionUserListType);

  Future<List<User>> getRepoActionUserList(String? username,
          ActionUserListType actionUserListType, String? repoName) =>
      _githubService.getRepoActionUserList(
          username, actionUserListType, repoName);
}
