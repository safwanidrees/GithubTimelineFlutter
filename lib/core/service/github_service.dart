import 'package:github_flutter/constants/enums.dart';
import 'package:github_flutter/core/networking/api_provider.dart';
import 'package:github_flutter/model/repositries.dart';
import 'package:github_flutter/model/user.dart';
import 'package:github_flutter/utils/api.dart';

class GithubService {
  final _apiProvider = ApiProvider();

  Future<List<Repositries>> getuserRepositriesList(String? username) async {
    final url = '${Api.api}/users/$username/repos';

    List<Repositries> reposList = [];
    final responce = await _apiProvider.get(
      url,
    );
    final responceData = responce as List;

    for (var e in responceData) {
      reposList.add(Repositries.fromMap(e));
    }

    return reposList;
  }

  Future<User> getUserProfile(String? username) async {
    final url = '${Api.api}/users/$username';

    final responce = await _apiProvider.get(
      url,
    );

    final responceData = responce as Map<String, dynamic>;
    return User.fromMap(responceData);
  }

  Future<List<User>> getActionUserList(
    String? username,
    ActionUserListType actionUserListType,
  ) async {
    var url = '${Api.api}/users/$username';
    if (actionUserListType == ActionUserListType.followers) {
      url = '${Api.api}/users/$username/followers';
    } else if (actionUserListType == ActionUserListType.followings) {
      url = '${Api.api}/users/$username/following';
    }

    List<User> userList = [];
    final responce = await _apiProvider.get(
      url,
    );

    final responceData = responce as List;

    for (var e in responceData) {
      userList.add(User.fromMap(e));
    }

    return userList;
  }

  Future<List<User>> getRepoActionUserList(String? username,
      ActionUserListType actionUserListType, String? repoName) async {
    var url = '';
    if (actionUserListType == ActionUserListType.star) {
      url = "${Api.api}/repos/$username/$repoName/stargazers";
    } else if (actionUserListType == ActionUserListType.forks) {
      url = "${Api.api}/repos/$username/$repoName/forks";
    }

    List<User> userList = [];
    final responce = await _apiProvider.get(
      url,
    );

    final responceData = responce as List;

    for (var e in responceData) {
      userList.add(User.fromMap(
          actionUserListType == ActionUserListType.forks ? e["owner"] : e));
    }

    return userList;
  }
}
