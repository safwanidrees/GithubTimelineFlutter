import 'package:flutter/material.dart';
import 'package:github_flutter/constants/enums.dart';
import 'package:provider/provider.dart';

import 'package:github_flutter/core/bloc/github_bloc/github_bloc.dart';
import 'package:github_flutter/core/bloc/theme_bloc/theme_bloc.dart';
import 'package:github_flutter/model/user.dart';
import 'package:github_flutter/routes/routes.dart';
import 'package:github_flutter/screen/profile_screen/components/counter_text.dart';
import 'package:github_flutter/utils/app_date_utils.dart';
import 'package:github_flutter/utils/theme.dart';
import 'package:github_flutter/widgets/card_image.dart';
import 'package:github_flutter/widgets/shimmer_loader.dart';

class ProfileTopView extends StatelessWidget {
  const ProfileTopView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Consumer<GithubBloc>(builder: (context, githubBloc, _) {
          if (githubBloc.currentUserState == CurrentUserState.loading) {
            return const ShimmerLoader(
              showPadding: true,
              isList: false,
            );
          } else if (githubBloc.currentUserState == CurrentUserState.loaded) {
            User user = githubBloc.currentUser!;

            return Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Align(
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CardImage(
                      key: const ValueKey('image.user'),
                      imageUrl: user.imageUrl,
                      height: 120,
                      width: 120,
                      shape: BoxShape.circle,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15, bottom: 2),
                      child: Text(user.name.toString(),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 2, bottom: 2),
                      child: Text("@ ${user.username.toString()}",
                          style: TextStyle(fontSize: 14, color: AppTheme.grey)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 2, bottom: 2),
                      child: Text(
                          user.bio
                              .toString()
                              .trim()
                              .replaceAll(RegExp(r'(\n){3,}'), "\n\n"),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w400)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 2, bottom: 2),
                      child: Text(AppDateUtils.formatDate(user.joinedDate),
                          style: TextStyle(fontSize: 12, color: AppTheme.grey)),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CouterText(
                          onTap: () {
                            if (githubBloc.currentUserName != null) {
                              Routes.toPage(context,
                                  "/profile/${githubBloc.currentUserName}/followers",
                                  replace: false);
                            }
                          },
                          counter: user.followers,
                          text: "Followers",
                        ),

                        // const SizedBox(width: 20),

                        CouterText(
                          onTap: () {
                            if (githubBloc.currentUserName != null) {
                              Routes.toPage(context,
                                  "/profile/${githubBloc.currentUserName}/following",
                                  replace: false);
                            }
                          },
                          counter: user.followings,
                          text: "Followings",
                        ),

                        CouterText(
                          onTap: () {
                            if (githubBloc.currentUserName != null) {
                              Routes.toPage(context,
                                  "/profile/${githubBloc.currentUserName}/repos",
                                  replace: false);
                            }
                          },
                          counter: user.publicRepo,
                          text: "Repositories",
                        ),
                      ],
                    ),
                    const Divider(),
                  ],
                ),
              ),
            );
          } else {
            return Container();
          }
        }),
        Positioned(
          top: 10,
          right: 0,
          child: FloatingActionButton(
            heroTag: "2",
            onPressed: () {
              context.read<ThemeBloc>().darkTheme =
                  !context.read<ThemeBloc>().darkTheme;
            },
            child: Icon(
              context.watch<ThemeBloc>().darkTheme
                  ? Icons.wb_sunny_outlined
                  : Icons.nightlight_round,
              color: Theme.of(context).iconTheme.color,
            ),
          ),
        ),
      ],
    );
  }
}
