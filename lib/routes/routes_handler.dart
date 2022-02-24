import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:github_flutter/constants/enums.dart';
import 'package:github_flutter/screen/follower_screen/follower_screen.dart';
import 'package:github_flutter/screen/profile_screen/components/profile_repo_view.dart';
import 'package:github_flutter/screen/profile_screen/profile_screen.dart';
import 'package:github_flutter/screen/search_page/search_screen.dart';

var rootHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return const SearchScreen();
});
var profileHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  String? username = params["username"]?.first;
  return ProfileScreen(username: username!);
});
var followerHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  String? username = params["username"]?.first;
  return ActionUserListScreen(
    username: username!,
    actionUserListType: ActionUserListType.followers,
  );
});
var followingsHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  String? username = params["username"]?.first;
  return ActionUserListScreen(
    username: username!,
    actionUserListType: ActionUserListType.followings,
  );
});
var starsHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  String? username = params["username"]?.first;
  String? repoName = params["repo"]?.first;
  return ActionUserListScreen(
    username: username!,
    actionUserListType: ActionUserListType.star,
    repoName: repoName,
  );
});

var forksHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  String? username = params["username"]?.first;
  String? repoName = params["repo"]?.first;
  return ActionUserListScreen(
    username: username!,
    actionUserListType: ActionUserListType.forks,
    repoName: repoName,
  );
});

var repoHandler = Handler(
  handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
    String? username = params["username"]?.first;
    return Scaffold(
      body: SafeArea(
        child: ProfileRepoView(
          showProfile: true,
          showBackButton: true,
          username: username.toString(),
          isFullPage: true,
        ),
      ),
    );
  },
);
