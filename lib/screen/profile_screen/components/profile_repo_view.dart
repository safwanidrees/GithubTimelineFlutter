import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:github_flutter/core/bloc/github_bloc/github_bloc.dart';
import 'package:github_flutter/model/repositries.dart';

import 'package:github_flutter/screen/profile_screen/components/repo_card.dart';
import 'package:github_flutter/constants/enums.dart';
import 'package:github_flutter/utils/responsive_size.dart';
import 'package:github_flutter/widgets/card_image.dart';
import 'package:github_flutter/widgets/fade_widget.dart';
import 'package:github_flutter/widgets/shimmer_loader.dart';
import 'package:provider/provider.dart';

class ProfileRepoView extends StatefulWidget {
  final bool showProfile;
  final bool showBackButton;
  final String? username;
  final bool isFullPage;
  const ProfileRepoView({
    Key? key,
    required this.showProfile,
    this.showBackButton = false,
    this.username,
    this.isFullPage = false,
  }) : super(key: key);

  @override
  State<ProfileRepoView> createState() => _ProfileRepoViewState();
}

class _ProfileRepoViewState extends State<ProfileRepoView> {
  final ScrollController _scrollController2 = ScrollController();
  @override
  void initState() {
    if (context.read<GithubBloc>().currentUserState ==
            CurrentUserState.initial &&
        widget.username != null) {
      context.read<GithubBloc>().getUserProfile(widget.username);
    }
    if (context.read<GithubBloc>().currentUserRepoListState ==
            CurrentUserRepoListState.initial &&
        widget.username != null) {
      context.read<GithubBloc>().getuserRepositriesList(widget.username);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GithubBloc>(builder: (context, githubBloc, _) {
      if (githubBloc.currentUserRepoListState ==
          CurrentUserRepoListState.loading) {
        return const ShimmerLoader(
          showPadding: true,
        );
      } else if (githubBloc.currentUserRepoListState ==
          CurrentUserRepoListState.error) {
        return const Center(child: Text("An error occurs"));
      } else if (githubBloc.currentUserRepoListState ==
          CurrentUserRepoListState.loaded) {
        // return ShimmerLoader(
        //   showPadding: true,
        // );
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Visibility(
              visible: widget.showProfile,
              child: FadeWidget(
                child: Padding(
                    padding: const EdgeInsets.only(
                        top: 10, bottom: 0, left: 16, right: 16),
                    child: Row(
                      children: [
                        widget.showBackButton && !kIsWeb
                            ? IconButton(
                                icon: const Icon(Icons.arrow_back_ios),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              )
                            : Container(),
                        CardImage(
                          imageUrl: githubBloc.currentUser!.imageUrl,
                          height: 35,
                          width: 35,
                          shape: BoxShape.circle,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Text(
                            githubBloc.currentUser!.name.toString(),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        )
                      ],
                    )),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: widget.showProfile ? 10 : 0,
                  bottom: 15,
                  left: 16,
                  right: 16),
              child: const Text(
                "Repositories",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            widget.isFullPage
                ? Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(18),
                        child: LayoutBuilder(builder: (ctx, screen) {
                          dynamic ratio;
                          dynamic count;
                          var size = ResponsiveSize.sizeWidth(context);
                          if (size > 2000) {
                            count = 5;
                            ratio =
                                ResponsiveSize.sizeWidth(context) * 0.22 / 190;
                          } else if (size > 1700) {
                            count = 4;
                            ratio =
                                ResponsiveSize.sizeWidth(context) * 0.22 / 190;
                          } else if (size > 1200) {
                            count = 3;
                            ratio =
                                ResponsiveSize.sizeWidth(context) * 0.35 / 190;
                          } else {
                            count = 2;
                            ratio =
                                ResponsiveSize.sizeWidth(context) * 0.47 / 190;
                          }

                          return ResponsiveSize.sizeWidth(context) > 800
                              ? GridView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  itemCount:
                                      githubBloc.currentUserRepoList.length,
                                  itemBuilder: (ctx, proindex) {
                                    Repositries repositry = githubBloc
                                        .currentUserRepoList[proindex];
                                    return RepoCard(repositry: repositry);
                                  },
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: count,
                                          crossAxisSpacing: 10,
                                          mainAxisSpacing: 0,
                                          childAspectRatio: ratio))
                              : ListView.builder(
                                  controller: _scrollController2,
                                  // physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount:
                                      githubBloc.currentUserRepoList.length,
                                  itemBuilder: (ctx, i) {
                                    Repositries repositry =
                                        githubBloc.currentUserRepoList[i];
                                    return RepoCard(repositry: repositry);
                                  });
                        }),
                      ),
                    ),
                  )
                : kIsWeb
                    ? LayoutBuilder(builder: (ctx, screen) {
                        dynamic ratio;
                        dynamic count;
                        var size = ResponsiveSize.sizeWidth(context);
                        if (size > 1700) {
                          count = 3;
                          ratio =
                              ResponsiveSize.sizeWidth(context) * 0.22 / 190;
                        } else if (size > 1200) {
                          count = 2;
                          ratio =
                              ResponsiveSize.sizeWidth(context) * 0.35 / 190;
                        } else {
                          count = 1;
                          ratio =
                              ResponsiveSize.sizeWidth(context) * 0.58 / 190;
                        }

                        return ResponsiveSize.sizeWidth(context) > 940
                            ? GridView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                itemCount:
                                    githubBloc.currentUserRepoList.length,
                                itemBuilder: (ctx, proindex) {
                                  Repositries repositry =
                                      githubBloc.currentUserRepoList[proindex];
                                  return RepoCard(repositry: repositry);
                                },
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: count,
                                        crossAxisSpacing: 10,
                                        mainAxisSpacing: 0,
                                        childAspectRatio: ratio))
                            : Expanded(
                                child: ListView.builder(
                                    controller: _scrollController2,
                                    // physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount:
                                        githubBloc.currentUserRepoList.length,
                                    itemBuilder: (ctx, i) {
                                      Repositries repositry =
                                          githubBloc.currentUserRepoList[i];
                                      return RepoCard(repositry: repositry);
                                    }),
                              );
                      })
                    : Expanded(
                        child: Container(
                        margin: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
                        child: ListView.builder(
                            // physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: githubBloc.currentUserRepoList.length,
                            itemBuilder: (ctx, i) {
                              Repositries repositry =
                                  githubBloc.currentUserRepoList[i];
                              return RepoCard(repositry: repositry);
                            }),
                      ))
          ],
        );
      } else {
        return Container();
      }
    });
  }
}
