import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:github_flutter/constants/enums.dart';
import 'package:github_flutter/core/bloc/github_bloc/github_bloc.dart';

import 'package:github_flutter/screen/profile_screen/components/profile_mobile_view.dart';
import 'package:github_flutter/screen/profile_screen/components/profile_webview.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  final String username;
  const ProfileScreen({
    Key? key,
    required this.username,
  }) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ValueNotifier<bool> isScroll = ValueNotifier(false);
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      Provider.of<GithubBloc>(context, listen: false)
          .getUserProfile(widget.username);
      Provider.of<GithubBloc>(context, listen: false)
          .getuserRepositriesList(widget.username);

      Provider.of<GithubBloc>(context, listen: false)
          .setCurrentUserName(widget.username);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GithubBloc>(builder: (context, githubBloc, _) {
      return Scaffold(
          appBar: githubBloc.currentUserState == CurrentUserState.error
              ? AppBar()
              : AppBar(
                  toolbarHeight: 0,
                  leading: Container(),
                ),
          body: githubBloc.currentUserState == CurrentUserState.error
              ? Center(
                  child: Text(
                  githubBloc.currentUserException.toString(),
                  textAlign: TextAlign.center,
                ))
              : kIsWeb
                  ? const ProfileWebView()
                  : const ProfileMobileView());
    });
  }
}
