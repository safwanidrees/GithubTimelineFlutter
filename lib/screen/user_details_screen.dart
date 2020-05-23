import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:github_flutter/providers/user_provider.dart';
import 'package:github_flutter/screen/repo_screen.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class UserDetailsScreen extends StatefulWidget {
  String username;
  UserDetailsScreen({this.username});
  @override
  _UserDetailsScreenState createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  var _init = true;
  var _isLoading = false;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if (_init) {
      setState(() {
        _isLoading = true;
      });

      Provider.of<UserProvider>(context)
          .getUserProfile(widget.username)
          .then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _init = false;
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    final size = MediaQuery.of(context).size;
    var textStyle = TextStyle(fontFamily: 'Lato', fontSize: 18);
    final f = new DateFormat.yMMMMd("en_US");
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.username),
          backgroundColor: Color(0xff330033),
          centerTitle: true,
          elevation: 0,
        ),
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : user.user.username == null &&
                    user.user.followers == null &&
                    user.user.imageUrl == null &&
                    user.user.followings == null &&
                    user.user.public_repo == null
                ? Center(
                    child: Text('Nothing Found'),
                  )
                : Column(
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          Stack(
                            children: <Widget>[
                              Container(
                                height: size.height * 0.4,
                                color: Colors.white,
                              ),
                              Container(
                                height: size.height * 0.23,
                                color: Color(0xff330033),
                              ),
                              Positioned(
                                top: size.height * 0.15,
                                left: size.width * 0.35,
                                child: Column(
                                  children: <Widget>[
                                    ClipRRect(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(100.0)),
                                      child: CachedNetworkImage(
                                        placeholder: (context, url) =>
                                            Container(
                                          child: CircularProgressIndicator(
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                    Color(0xff330033)),
                                          ),
                                          width: 121.0,
                                          height: 121.0,
                                          padding: EdgeInsets.all(70.0),
                                          decoration: BoxDecoration(
                                            color: Colors.grey[300],
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(8.0),
                                            ),
                                          ),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            Material(
                                          child: Image.asset(
                                            'assets/images/img_not_available.jpeg',
                                            width: 121.0,
                                            height: 121.0,
                                            fit: BoxFit.cover,
                                          ),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(8.0),
                                          ),
                                          clipBehavior: Clip.hardEdge,
                                        ),
                                        imageUrl: user.user.imageUrl.toString(),
                                        width: 121.0,
                                        height: 121.0,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        user.user.username,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Lato'),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      // for(int i=0;i<githubinfo.length;i++)
                      Container(
                        height: 1,
                        color: Colors.grey[300],
                      ),
                      SizedBox(
                        height: 10,
                      ),

                      Padding(
                        padding: const EdgeInsets.all(13.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Image.asset('assets/images/user-shield.png'),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    'Followings',
                                    style: textStyle,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              user.user.followings.toString(),
                              style: textStyle,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(13.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
//                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Image.asset('assets/images/github-2.png'),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    'Followers',
                                    style: textStyle,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              user.user.followers.toString(),
                              style: textStyle,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        height: 1,
                        color: Colors.grey[300],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      InkWell(
                        //   onTap: () {
                        //     Navigator.of(context).push(MaterialPageRoute(
                        //         builder: (ctx) =>
                        //             RepositriesScreen(username)));
                        //   },

                        child: Padding(
                          padding: const EdgeInsets.all(13.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (ctx) => RepositiriesScreen(user.user.username)));
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Image.asset(
                                        'assets/images/user-male-circle.png'),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Text('Public Repositries',
                                          style: textStyle),
                                    ),
                                  ],
                                ),
                                Text(user.user.public_repo.toString(),
                                    style: textStyle),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        height: 1,
                        color: Colors.grey[300],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Joined at ${f.format(DateTime.parse(user.user.joined_date))} ',
                          style: TextStyle(
                              fontFamily: 'Lato',
                              fontSize: 15,
                              color: Colors.grey[400]),
                        ),
                      ),
                    ],
                  ));
  }
}
