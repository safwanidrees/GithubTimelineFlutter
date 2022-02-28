import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:github_flutter/constants/enums.dart';
import 'package:github_flutter/core/bloc/github_bloc/github_bloc.dart';
import 'package:github_flutter/routes/routes.dart';
import 'package:github_flutter/widgets/card_image.dart';
import 'package:github_flutter/widgets/shimmer_loader.dart';
import 'package:provider/provider.dart';

class ActionUserListScreen extends StatefulWidget {
  final String username;
  final ActionUserListType actionUserListType;
  final String? repoName;

  const ActionUserListScreen(
      {Key? key,
      required this.username,
      required this.actionUserListType,
      this.repoName})
      : super(key: key);

  @override
  State<ActionUserListScreen> createState() => _ActionUserListScreenState();
}

class _ActionUserListScreenState extends State<ActionUserListScreen> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      context.read<GithubBloc>().getActionUserList(
          widget.username, widget.actionUserListType,
          repoName: widget.repoName);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Users"),
          leading: !kIsWeb
              ? IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              : Container(),
        ),
        body: Consumer<GithubBloc>(builder: (ctx, githubBloc, _) {
          if (githubBloc.currenActionUserListState ==
              ActionUserListState.loading) {
            return const ShimmerLoader(
              showPadding: false,
              isUserList: true,
            );
          } else if (githubBloc.currenActionUserListState ==
              ActionUserListState.error) {
            return Center(
                child:
                    Text(githubBloc.userRepositriesListException.toString()));
          } else if (githubBloc.currenActionUserListState ==
              ActionUserListState.loaded) {
            return ListView.separated(
                itemBuilder: (context, i) => ListTile(
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();

                        Routes.toPage(context,
                            "/profile/${githubBloc.usersList[i].toMap()["login"]}",
                            replace: false);
                      },
                      leading: CardImage(
                        height: 50,
                        width: 50,
                        radius: 50,
                        imageUrl: githubBloc.usersList[i].imageUrl,
                      ),
                      title: Text(githubBloc.usersList[i].username.toString()),
                    ),
                separatorBuilder: (context, i) => const Divider(),
                itemCount: githubBloc.usersList.length);
          } else {
            return Container();
          }
        }));
  }
}
