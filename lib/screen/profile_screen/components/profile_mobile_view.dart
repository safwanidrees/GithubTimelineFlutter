import 'package:flutter/material.dart';
import 'package:github_flutter/screen/profile_screen/components/profile_repo_view.dart';
import 'package:github_flutter/screen/profile_screen/components/profile_top_view.dart';

class ProfileMobileView extends StatefulWidget {
  const ProfileMobileView({Key? key}) : super(key: key);

  @override
  State<ProfileMobileView> createState() => _ProfileMobileViewState();
}

class _ProfileMobileViewState extends State<ProfileMobileView> {
  late final ScrollController _scrollController = ScrollController();
  ValueNotifier<bool> isScroll = ValueNotifier(false);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: NestedScrollView(
      controller: _scrollController,
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        isScroll.value = innerBoxIsScrolled;
        return <Widget>[
          SliverAppBar(
            leading: Container(),
            leadingWidth: 0,
            toolbarHeight: 350,
            title: const ProfileTopView(),
            centerTitle: true,
          )
        ];
      },
      body: Hero(
        tag: 'test',
        child: ValueListenableBuilder<bool>(
            valueListenable: isScroll,
            builder: (context, v, _) {
              return ProfileRepoView(
                showProfile: v,
              );
            }),
      ),
    ));
  }
}
