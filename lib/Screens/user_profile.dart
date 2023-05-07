import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';
import 'package:brands_app/BottomNavigation/Explore/explore_page.dart';
import 'package:brands_app/Components/profile_page_button.dart';
import 'package:brands_app/Components/row_item.dart';
import 'package:brands_app/Components/sliver_app_delegate.dart';
import 'package:brands_app/Components/tab_grid.dart';
import 'package:brands_app/Locale/locale.dart';
import 'package:brands_app/Routes/routes.dart';
import 'package:brands_app/BottomNavigation/MyProfile/followers.dart';
import 'package:brands_app/Theme/colors.dart';
import 'package:brands_app/BottomNavigation/MyProfile/following.dart';

class UserProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return UserProfileBody();
  }
}

class UserProfileBody extends StatefulWidget {
  @override
  _UserProfileBodyState createState() => _UserProfileBodyState();
}

class _UserProfileBodyState extends State<UserProfileBody> {
  bool isFollowed = false;

  var followText;
  final key = UniqueKey();

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: darkColor,
      body: DefaultTabController(
        length: 2,
        child: SafeArea(
          child: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  expandedHeight: 400.0,
                  floating: false,
                  actions: <Widget>[
                    PopupMenuButton(
                      color: backgroundColor,
                      icon: Icon(
                        Icons.more_vert,
                        color: secondaryColor,
                      ),
                      shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide.none),
                      itemBuilder: (BuildContext context) {
                        return [
                          PopupMenuItem(
                            value: locale?.report,
                            textStyle: TextStyle(color: secondaryColor),
                            child: Text(locale!.report!),
                          ),
                          PopupMenuItem(
                            value: locale.block,
                            textStyle: TextStyle(color: secondaryColor),
                            child: Text(locale.block!),
                          ),
                        ];
                      },
                    )
                  ],
                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    title: Column(
                      children: <Widget>[
                        Spacer(flex: 10),
                        FadedScaleAnimation(
                          child: CircleAvatar(
                            radius: 28.0,
                            backgroundImage:
                                AssetImage('assets/user/user1.png'),
                          ),
                        ),
                        Spacer(),
                        Row(
                          children: [
                            Spacer(flex: 12),
                            Text(
                              'Emili Williamson',
                              style: TextStyle(fontSize: 16),
                            ),
                            Spacer(),
                            Image.asset(
                              'assets/icons/ic_verified.png',
                              scale: 4,
                            ),
                            Spacer(flex: 8),
                          ],
                        ),
                        Text(
                          '@emilithedancer',
                          style:
                              TextStyle(fontSize: 10, color: disabledTextColor),
                        ),
                        Spacer(),
                        FadedScaleAnimation(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              ImageIcon(
                                AssetImage(
                                  "assets/icons/ic_fb.png",
                                ),
                                color: secondaryColor,
                                size: 10,
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              ImageIcon(
                                AssetImage("assets/icons/ic_twt.png"),
                                color: secondaryColor,
                                size: 10,
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              ImageIcon(
                                AssetImage("assets/icons/ic_insta.png"),
                                color: secondaryColor,
                                size: 10,
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                        Text(
                          locale!.comment7!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 10, fontWeight: FontWeight.w500),
                        ),
                        Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            ProfilePageButton(
                                locale.message,
                                () => Navigator.pushNamed(
                                    context, PageRoutes.chatPage)),
                            SizedBox(width: 16),
                            isFollowed
                                ? ProfilePageButton(locale.following, () {
                                    setState(() {
                                      isFollowed = false;
                                    });
                                  })
                                : ProfilePageButton(
                                    locale.follow,
                                    () {
                                      setState(() {
                                        isFollowed = true;
                                      });
                                    },
                                    color: mainColor,
                                    textColor: secondaryColor,
                                  ),
                          ],
                        ),
                        Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            RowItem(
                                '1.2m',
                                locale.liked,
                                Scaffold(
                                  appBar: AppBar(
                                    title: Text('Liked'),
                                  ),
                                  body: TabGrid(
                                    food + lol,
                                  ),
                                )),
                            RowItem('12.8k', locale.followers, FollowersPage()),
                            RowItem('1.9k', locale.following, FollowingPage()),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SliverPersistentHeader(
                  delegate: SliverAppBarDelegate(
                    TabBar(
                      labelColor: mainColor,
                      unselectedLabelColor: lightTextColor,
                      indicatorColor: transparentColor,
                      tabs: const [
                        Tab(icon: Icon(Icons.dashboard)),
                        Tab(
                          icon: ImageIcon(AssetImage(
                            'assets/icons/ic_like.png',
                          )),
                        ),
                      ],
                    ),
                  ),
                  pinned: true,
                ),
              ];
            },
            body: TabBarView(
              children: <Widget>[
                FadedSlideAnimation(
                  beginOffset: Offset(0, 0.3),
                  endOffset: Offset(0, 0),
                  slideCurve: Curves.linearToEaseOut,
                  child: TabGrid(dance),
                ),
                FadedSlideAnimation(
                  beginOffset: Offset(0, 0.3),
                  endOffset: Offset(0, 0),
                  slideCurve: Curves.linearToEaseOut,
                  child: TabGrid(food + lol),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
