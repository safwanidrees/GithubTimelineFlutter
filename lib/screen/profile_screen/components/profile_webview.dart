import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:github_flutter/screen/profile_screen/components/profile_repo_view.dart';
import 'package:github_flutter/screen/profile_screen/components/profile_top_view.dart';
import 'package:github_flutter/utils/responsive_size.dart';

class ProfileWebView extends StatelessWidget {
  const ProfileWebView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scrollbar(
        isAlwaysShown: kIsWeb ? true : false,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: ResponsiveSize.sizeWidth(context) < 940
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        // padding: const EdgeInsets.all(8.0),
                        margin:
                            const EdgeInsets.only(right: 35, top: 0, left: 35),
                        child: const ProfileTopView(),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 35, right: 35),
                        child: const ProfileRepoView(
                          showProfile: false,
                        ),
                      )
                    ],
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          width: ResponsiveSize.sizeWidth(context) * 0.3,
                          margin: const EdgeInsets.only(
                              left: 35, right: 50, top: 0),
                          child: const ProfileTopView(),
                        ),
                      ),
                      const Expanded(
                        flex: 2,
                        child: Padding(
                          padding: EdgeInsets.only(right: 35),
                          child: ProfileRepoView(
                            showProfile: false,
                          ),
                        ),
                      )
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
