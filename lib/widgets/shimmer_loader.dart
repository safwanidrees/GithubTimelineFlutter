import 'package:flutter/material.dart';
import 'package:github_flutter/utils/responsive_size.dart';

import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:github_flutter/utils/theme.dart';

class ShimmerLoader extends StatelessWidget {
  final bool isList;
  final bool showPadding;
  final bool isUserList;

  const ShimmerLoader(
      {Key? key,
      this.isList = true,
      this.showPadding = false,
      this.isUserList = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(showPadding ? 25.0 : 0),
        child: isUserList
            ? ListView.separated(
                separatorBuilder: (ctx, i) => const Divider(),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (_, i) {
                  return const ListTile(
                    leading: ShimmerCard(
                      radius: 100,
                      height: 50,
                      width: 50,
                    ),
                    title: ShimmerCard(
                      radius: 10,
                      height: 10,
                      width: 0,
                    ),
                  );
                },
                itemCount: 6,
              )
            : isList
                ? ListView.separated(
                    separatorBuilder: (ctx, i) => const Divider(),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (_, i) {
                      return const ShimmerRepoCard();
                    },
                    itemCount: 6,
                  )
                : const ShimmerUserProfile()

        // ),
        );
  }
}

class ShimmerUserProfile extends StatelessWidget {
  const ShimmerUserProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.center,
        child: Column(
          children: [
            const ShimmerCard(
              radius: 100,
              height: 80,
              width: 80,
            ),
            const SizedBox(
              height: 10,
            ),
            ShimmerCard(
              radius: 10,
              height: 15,
              width: ResponsiveSize.sizeWidth(context) * 0.2,
            ),
            const SizedBox(
              height: 10,
            ),
            ShimmerCard(
              radius: 10,
              height: 15,
              width: ResponsiveSize.sizeWidth(context) * 0.6,
            ),
            const SizedBox(
              height: 10,
            ),
            ShimmerCard(
              radius: 10,
              height: 15,
              width: ResponsiveSize.sizeWidth(context) * 0.1,
            ),
            const SizedBox(
              height: 80,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                ShimmerCard(
                  radius: 10,
                  height: 50,
                  width: 50,
                ),
                SizedBox(
                  width: 10,
                ),
                ShimmerCard(
                  radius: 10,
                  height: 50,
                  width: 50,
                ),
                SizedBox(
                  width: 10,
                ),
                ShimmerCard(
                  radius: 10,
                  height: 50,
                  width: 50,
                ),
              ],
            )
          ],
        ));
  }
}

class ShimmerRepoCard extends StatelessWidget {
  const ShimmerRepoCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10, top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ShimmerCard(
                radius: 10,
                height: 15,
                width: ResponsiveSize.sizeWidth(context) * 0.3,
              ),
              Row(
                children: const [
                  ShimmerCard(
                    radius: 10,
                    height: 30,
                    width: 30,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  ShimmerCard(
                    radius: 10,
                    height: 30,
                    width: 30,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  ShimmerCard(
                    radius: 10,
                    height: 30,
                    width: 30,
                  ),
                ],
              )
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          ShimmerCard(
            radius: 10,
            height: 15,
            width: ResponsiveSize.sizeWidth(context) * 0.5,
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: const [
                  ShimmerCard(
                    radius: 5,
                    height: 20,
                    width: 40,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  ShimmerCard(
                    radius: 5,
                    height: 20,
                    width: 40,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  ShimmerCard(
                    radius: 5,
                    height: 20,
                    width: 40,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                ],
              ),
              ShimmerCard(
                radius: 10,
                height: 15,
                width: ResponsiveSize.sizeWidth(context) * 0.1,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ShimmerCard extends StatelessWidget {
  final double width;
  final double height;
  final double radius;

  const ShimmerCard({
    Key? key,
    required this.width,
    required this.height,
    required this.radius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeShimmer(
      width: width,
      height: height,
      radius: radius,
      baseColor: Theme.of(context).scaffoldBackgroundColor,
      highlightColor: AppTheme.shimmerColor,
      millisecondsDelay: 0,
    );
  }
}
