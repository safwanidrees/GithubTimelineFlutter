import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:github_flutter/core/bloc/github_bloc/github_bloc.dart';

import 'package:github_flutter/model/repositries.dart';
import 'package:github_flutter/routes/routes.dart';
import 'package:github_flutter/utils/app_date_utils.dart';
import 'package:github_flutter/utils/app_images.dart';
import 'package:github_flutter/utils/theme.dart';
import 'package:provider/provider.dart';

class RepoCard extends StatelessWidget {
  final Repositries repositry;
  const RepoCard({
    Key? key,
    required this.repositry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppTheme.grey),
        ),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 12, right: 12, bottom: 5, top: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          repositry.repoName.toString(),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                      Row(
                        children: [
                          InkWell(
                            borderRadius: BorderRadius.circular(10),
                            onTap: () {
                              context
                                  .read<GithubBloc>()
                                  .copyRepository(repositry.url);
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(Icons.copy),
                            ),
                          ),
                          InkWell(
                            borderRadius: BorderRadius.circular(10),
                            onTap: () {
                              context
                                  .read<GithubBloc>()
                                  .downloadRepository(repositry.url, context);
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(Icons.download),
                            ),
                          ),
                          kIsWeb
                              ? Container()
                              : InkWell(
                                  borderRadius: BorderRadius.circular(10),
                                  onTap: () {
                                    context.read<GithubBloc>().shareRepository(
                                        repositry.url, context);
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Icon(Icons.share),
                                  ),
                                )
                        ],
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Text(
                      repositry.description.toString(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontWeight: FontWeight.w400, fontSize: 14),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        repositry.language == ""
                            ? Container()
                            : Padding(
                                padding: const EdgeInsets.only(
                                    right: 8, top: 8, bottom: 8),
                                child: Text(
                                  repositry.language.toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 10),
                                ),
                              ),
                        InkWell(
                          borderRadius: BorderRadius.circular(7),
                          onTap: () {
                            Routes.toPage(context,
                                "/profile/${Provider.of<GithubBloc>(context, listen: false).currentUserName}/${repositry.repoName}/stars_users",
                                replace: false);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  size: 18,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  repositry.stars.toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          borderRadius: BorderRadius.circular(7),
                          onTap: () {
                            Routes.toPage(context,
                                "/profile/${Provider.of<GithubBloc>(context, listen: false).currentUserName}/${repositry.repoName}/forks_users",
                                replace: false);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Image.asset(AppImages.ic_fork,
                                    height: 20,
                                    width: 20,
                                    color: Theme.of(context).iconTheme.color),
                                const SizedBox(width: 5),
                                Text(
                                  repositry.forks.toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Text(
                          "Last Pushed: ${AppDateUtils.formatDate(repositry.lastPushed.toString())}",
                          style: const TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 10),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
