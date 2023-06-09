import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';
import 'package:brands_app/BottomNavigation/Explore/explore_page.dart';
import 'package:brands_app/Locale/locale.dart';
import 'package:brands_app/Routes/routes.dart';
import 'package:brands_app/Theme/colors.dart';
import 'package:brands_app/Extension/extensions.dart';
import 'package:brands_app/Components/tab_grid.dart';

class User {
  User(this.name, this.id, this.img);
  String name;
  String id;
  String img;
}

class SearchUsers extends StatefulWidget {
  @override
  _SearchUsersState createState() => _SearchUsersState();
}

class _SearchUsersState extends State<SearchUsers> {
  final _controller = TextEditingController();
  List<User> names = [
    User("Food Master", "@georgesmith", "assets/user/user1.png"),
    User("Foody Girl", "@emiliwilliamson", "assets/user/user2.png"),
    User("Foodzilla", "@foodyzilla", "assets/user/user3.png"),
    User("Linda Johnson", "@lindahere", "assets/user/user4.png"),
    User("Opus Labs", "@opuslabs", "assets/user/user1.png"),
    User("Ling Tong", "@lingtong", "assets/user/user2.png"),
    User("Tosh Williamson", "@toshwilliamson", "assets/user/user3.png"),
    User("Linda Johnson", "@lindahere", "assets/user/user4.png"),
    User("Food Master", "@georgesmith", "assets/user/user1.png"),
    User("Foody Girl", "@emiliwilliamson", "assets/user/user2.png"),
    User("Foodzilla", "@foodyzilla", "assets/user/user3.png"),
    User("Linda Johnson", "@lindahere", "assets/user/user4.png"),
  ];

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context)!;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(66.0),
            child: Column(
              children: <Widget>[
                Container(
                  margin:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                  decoration: BoxDecoration(
                    color: darkColor,
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                        icon: IconButton(
                          icon: Icon(Icons.arrow_back),
                          color: secondaryColor,
                          onPressed: () => Navigator.pop(context),
                        ),
                        border: InputBorder.none,
                        hintText: AppLocalizations.of(context)!.search,
                        hintStyle: Theme.of(context).textTheme.titleMedium,
                        suffixIcon: IconButton(
                          icon: Icon(Icons.close),
                          color: secondaryColor,
                          onPressed: _controller.clear,
                        )),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: TabBar(
                    indicator: BoxDecoration(color: transparentColor),
                    isScrollable: true,
                    labelColor: mainColor,
                    labelStyle: Theme.of(context).textTheme.titleLarge,
                    unselectedLabelColor: disabledTextColor,
                    tabs: <Widget>[
                      Tab(text: local.video!.capitalize()),
                      Tab(text: local.users),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            FadedSlideAnimation(
              beginOffset: Offset(0, 0.3),
              endOffset: Offset(0, 0),
              slideCurve: Curves.linearToEaseOut,
              child: TabGrid(
                dance + food,
                onTap: () =>
                    Navigator.pushNamed(context, PageRoutes.videoOptionPage),
              ),
            ),
            FadedSlideAnimation(
              beginOffset: Offset(0, 0.3),
              endOffset: Offset(0, 0),
              slideCurve: Curves.linearToEaseOut,
              child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: names.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Column(
                      children: <Widget>[
                        Divider(
                          color: darkColor,
                          height: 1.0,
                          thickness: 1,
                        ),
                        ListTile(
                          leading: FadedScaleAnimation(
                            child: CircleAvatar(
                              backgroundColor: darkColor,
                              backgroundImage: AssetImage(names[index].img),
                            ),
                          ),
                          title: Text(
                            names[index].name,
                            style: TextStyle(color: Colors.white),
                          ),
                          subtitle: Text(names[index].id),
                          onTap: () => Navigator.pushNamed(
                              context, PageRoutes.userProfilePage),
                        ),
                      ],
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
