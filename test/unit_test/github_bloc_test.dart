import 'package:flutter_test/flutter_test.dart';
import 'package:github_flutter/constants/enums.dart';
import 'package:github_flutter/core/bloc/github_bloc/github_bloc.dart';

void main() {
  final githubBloc = GithubBloc();
  test("Should get user profile detail", () async {
    await githubBloc.getUserProfile("safwanidrees");
    expect(githubBloc.currentUser, isNotNull);
  });
  test("Should get all repositories", () async {
    await githubBloc.getuserRepositriesList("safwanidrees");
    expect(githubBloc.currentUserRepoList, isNotEmpty);
  });

  test("Should get all user followers", () async {
    await githubBloc.getActionUserList(
        "safwanidrees", ActionUserListType.followers);
    expect(githubBloc.usersList, isNotEmpty);
  });

  test("Should get all user followings", () async {
    githubBloc.clearUserList();
    await githubBloc.getActionUserList(
        "safwanidrees", ActionUserListType.followings);
    expect(githubBloc.usersList, isNotEmpty);
  });
}
