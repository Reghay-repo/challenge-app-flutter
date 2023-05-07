import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:brands_app/BottomNavigation/Explore/explore_page.dart';
import 'package:brands_app/BottomNavigation/Home/home_page.dart';
import 'package:brands_app/BottomNavigation/MyProfile/my_profile_page.dart';
import 'package:brands_app/Locale/locale.dart';
import 'package:brands_app/Routes/routes.dart';
import 'package:brands_app/BottomNavigation/Notifications/notification_messages.dart';
import 'package:brands_app/Theme/colors.dart';
import 'package:brands_app/Theme/style.dart';

import 'AddVideo/add_video.dart';

class BottomNavigation extends StatefulWidget {
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

final user = FirebaseAuth.instance.currentUser!;

class _BottomNavigationState extends State<BottomNavigation> {
  int _currentIndex = 0;
  Stream<DocumentSnapshot> snapshot =
      FirebaseFirestore.instance.collection("users").doc().snapshots();
  @override
  void initState() {
    setState(() {
      user.photoURL;
    });
    user.photoURL;
    super.initState();
  }

  final List<Widget> _children = [
    HomePage(),
    ExplorePage(),
    if (user.photoURL.toString() ==
        "https://example.com/jane-q-user/company.jpg")
      AddVideo(),
    NotificationMessages(),
    MyProfilePage(),
  ];

  Future onTap(int index) async {
    setState(() {
      _currentIndex = index;
      print(user.photoURL);
    });
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    final List<BottomNavigationBarItem> _bottomBarItems = [
      BottomNavigationBarItem(
        icon: ImageIcon(AssetImage('assets/icons/ic_home.png')),
        activeIcon: ImageIcon(AssetImage('assets/icons/ic_homeactive.png')),
        label: locale.home,
      ),
      BottomNavigationBarItem(
        icon: ImageIcon(AssetImage('assets/icons/ic_explore.png')),
        activeIcon: ImageIcon(AssetImage('assets/icons/ic_exploreactive.png')),
        label: locale.explore,
      ),
      if (user.photoURL.toString() ==
          "https://example.com/jane-q-user/company.jpg")
        BottomNavigationBarItem(
          icon: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Icon(
                Icons.add_circle_outline,
                size: 30,
                weight: 30.0,
                color: Colors.white,
              )),
          label: ' ',
        ),
      BottomNavigationBarItem(
        icon: ImageIcon(AssetImage('assets/icons/ic_notification.png')),
        activeIcon:
            ImageIcon(AssetImage('assets/icons/ic_notificationactive.png')),
        label: locale.notification,
      ),
      BottomNavigationBarItem(
        icon: ImageIcon(AssetImage('assets/icons/ic_profile.png')),
        activeIcon: ImageIcon(AssetImage('assets/icons/ic_profileactive.png')),
        label: locale.profile,
      ),
    ];

    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return Scaffold(
      body: FutureBuilder<DocumentSnapshot>(
          future: users.doc(user.uid).get(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              print(snapshot.hasData);
              return Center(child: CircularProgressIndicator());
            }

            return Stack(
              children: <Widget>[
                _children[_currentIndex],
                Align(
                  alignment: Alignment.bottomCenter,
                  child: BottomNavigationBar(
                    currentIndex: _currentIndex,
                    backgroundColor: transparentColor,
                    elevation: 0.0,
                    type: BottomNavigationBarType.fixed,
                    iconSize: 22.0,
                    selectedItemColor: secondaryColor,
                    selectedFontSize: 12,
                    unselectedFontSize: 10,
                    unselectedItemColor: secondaryColor,
                    items: _bottomBarItems,
                    onTap: onTap,
                  ),
                ),
              ],
            );
          }),
    );
  }
}
