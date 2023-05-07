import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:brands_app/Components/profile_page_button.dart';
import 'package:brands_app/Components/row_item.dart';
import 'package:brands_app/Components/sliver_app_delegate.dart';
import 'package:brands_app/Components/tab_grid.dart';
import 'package:brands_app/Locale/locale.dart';
import 'package:brands_app/Routes/routes.dart';
import 'package:brands_app/BottomNavigation/MyProfile/edit_profile.dart';
import 'package:brands_app/BottomNavigation/MyProfile/followers.dart';
import 'package:brands_app/Theme/colors.dart';
import 'package:brands_app/BottomNavigation/Explore/explore_page.dart';
import 'package:brands_app/BottomNavigation/MyProfile/following.dart';

class MyProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MyProfileBody();
  }
}

class MyProfileBody extends StatefulWidget {
  @override
  _MyProfileBodyState createState() => _MyProfileBodyState();
}

class _MyProfileBodyState extends State<MyProfileBody> {
  final user = FirebaseAuth.instance.currentUser!;
  final key = UniqueKey();
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    return Padding(
      padding: EdgeInsets.only(bottom: 64.0),
      child: Scaffold(
        backgroundColor: darkColor,
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.blue,
              Colors.red,
            ],
          )),
          child: Stack(
            children: [
              DefaultTabController(
                length: 3,
                child: SafeArea(
                  child: NestedScrollView(
                    floatHeaderSlivers: true,
                    headerSliverBuilder:
                        (BuildContext context, bool innerBoxIsScrolled) {
                      return <Widget>[
                        SliverAppBar(
                          stretch: true,
                          expandedHeight: 350.0,
                          floating: false,
                          actions: <Widget>[
                            Theme(
                              data: Theme.of(context).copyWith(
                                cardColor: backgroundColor,
                              ),
                              child: PopupMenuButton(
                                icon: Icon(
                                  Icons.more_vert,
                                  color: secondaryColor,
                                ),
                                shape: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                    borderSide: BorderSide.none),
                                onSelected: (dynamic value) {
                                  if (value == locale!.help) {
                                    Navigator.pushNamed(
                                        context, PageRoutes.helpPage);
                                  } else if (value == locale.termsOfUse) {
                                    Navigator.pushNamed(
                                        context, PageRoutes.tncPage);
                                  } else if (value == locale.logout) {
                                    FirebaseAuth.instance.signOut();
                                  }
                                },
                                itemBuilder: (BuildContext context) {
                                  return [
                                    PopupMenuItem(
                                      value: locale!.help,
                                      textStyle:
                                          TextStyle(color: secondaryColor),
                                      child: Text(locale.help!),
                                    ),
                                    PopupMenuItem(
                                      value: locale.termsOfUse,
                                      textStyle:
                                          TextStyle(color: secondaryColor),
                                      child: Text(locale.termsOfUse!),
                                    ),
                                    PopupMenuItem(
                                      value: locale.logout,
                                      textStyle:
                                          TextStyle(color: secondaryColor),
                                      child: Text(locale.logout!),
                                    )
                                  ];
                                },
                              ),
                            )
                          ],
                          flexibleSpace: FlexibleSpaceBar(
                            stretchModes: const <StretchMode>[
                              StretchMode.zoomBackground,
                              StretchMode.blurBackground
                            ],
                            centerTitle: true,
                            title: Column(
                              children: <Widget>[
                                Spacer(flex: 10),
                                CircleAvatar(
                                  radius: 28.0,
                                  backgroundImage:
                                      AssetImage('assets/images/user.webp'),
                                ),
                                Spacer(),
                                Text(
                                  '${user.displayName}',
                                  style: TextStyle(fontSize: 16),
                                ),
                                Text(
                                  '@${user.displayName}',
                                  style: TextStyle(
                                      fontSize: 10, color: disabledTextColor),
                                ),
                                Spacer(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    ImageIcon(
                                      AssetImage("assets/icons/ic_fb.png"),
                                      color: secondaryColor,
                                      size: 10,
                                    ),
                                    SizedBox(width: 16),
                                    ImageIcon(
                                      AssetImage("assets/icons/ic_twt.png"),
                                      color: secondaryColor,
                                      size: 10,
                                    ),
                                    SizedBox(
                                      width: 16,
                                    ),
                                    ImageIcon(
                                      AssetImage("assets/icons/ic_insta.png"),
                                      color: secondaryColor,
                                      size: 10,
                                    ),
                                  ],
                                ),
                                Spacer(),
                                Text(
                                  locale!.comment5!,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 8),
                                ),
                                Spacer(),
                                ProfilePageButton(
                                  locale.editProfile,
                                  () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                EditProfile()));
                                  },
                                  width: 120,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    RowItem(
                                        '1.2m',
                                        locale.liked,
                                        Scaffold(
                                          appBar: AppBar(
                                            title: Text('Liked'),
                                          ),
                                          body: TabGrid(
                                            food,
                                          ),
                                        )),
                                    RowItem('12.8k', locale.followers,
                                        FollowersPage()),
                                    RowItem('1.9k', locale.following,
                                        FollowingPage()),
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
                              tabs: [
                                if (user.photoURL.toString() ==
                                    "https://example.com/jane-q-user/company.jpg")
                                  Tab(icon: Icon(Icons.dashboard)),
                                Tab(icon: Icon(Icons.favorite_border)),
                                Tab(icon: Icon(Icons.bookmark_border)),
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
                          child: TabGrid(
                            food + food,
                            viewIcon: Icons.remove_red_eye,
                            views: '2.2k',
                            onTap: () => Navigator.pushNamed(
                                context, PageRoutes.videoOptionPage),
                          ),
                        ),
                        FadedSlideAnimation(
                          beginOffset: Offset(0, 0.3),
                          endOffset: Offset(0, 0),
                          slideCurve: Curves.linearToEaseOut,
                          child: TabGrid(
                            dance,
                            icon: Icons.favorite,
                          ),
                        ),
                        FadedSlideAnimation(
                          beginOffset: Offset(0, 0.3),
                          endOffset: Offset(0, 0),
                          slideCurve: Curves.linearToEaseOut,
                          child: TabGrid(
                            lol,
                            icon: Icons.bookmark,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
