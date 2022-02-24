// ignore_for_file: constant_identifier_names

import 'dart:io';

import 'package:fluro/fluro.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:github_flutter/routes/application.dart';
import 'package:github_flutter/routes/routes_handler.dart';

class Routes {
  static const home = "/";
  static const profile = "/profile/:username/";
  static const followers = "/profile/:username/followers/";
  static const following = "/profile/:username/following/";
  static const stars_users = "/profile/:username/:repo/stars_users/";
  static const forks_users = "/profile/:username/:repo/forks_users/";
  static const repos = "/profile/:username/repos/";

  static void configureRoutes(FluroRouter router) {
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
      return;
    });
    router.define(home, handler: rootHandler);
    router.define(profile, handler: profileHandler);
    router.define(followers, handler: followerHandler);
    router.define(following, handler: followingsHandler);
    router.define(stars_users, handler: starsHandler);
    router.define(forks_users, handler: forksHandler);
    router.define(repos, handler: repoHandler);
  }

  static Future<dynamic> popUp(BuildContext context, {var data}) async {
    if (data != null) {
      Application.router.pop(context, data);
    } else {
      Application.router.pop(context);
    }
  }

  static Future<dynamic> toPage(
    BuildContext context,
    String navigate, {
    bool replace = false,
    bool clearStack = false,
    bool maintainState = true,
    bool rootNavigator = false,
    Duration? transitionDuration,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transitionBuilder,
    RouteSettings? routeSettings,
  }) async {
    String page = navigate;
    if (navigate.substring(navigate.length - 1) != "/") {
      page = "$navigate/";
    }
    Application.router.navigateTo(
      context,
      page,
      replace: replace,
      clearStack: clearStack,
      maintainState: maintainState,
      rootNavigator: rootNavigator,
      transition: kIsWeb
          ? TransitionType.fadeIn
          : Platform.isAndroid
              ? TransitionType.material
              : TransitionType.cupertino,
      transitionDuration: transitionDuration,
      transitionBuilder: transitionBuilder,
      routeSettings: routeSettings,
    );
  }
}
