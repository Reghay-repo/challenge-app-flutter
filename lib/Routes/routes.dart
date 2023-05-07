import 'package:brands_app/Auth/Login/UI/login_page.dart';
import 'package:flutter/material.dart';
import 'package:brands_app/Auth/login_navigator.dart';
import 'package:brands_app/BottomNavigation/Explore/more_page.dart';
import 'package:brands_app/BottomNavigation/MyProfile/badge_request.dart';
import 'package:brands_app/BottomNavigation/MyProfile/language_page.dart';
import 'package:brands_app/BottomNavigation/MyProfile/video_option.dart';
import 'package:brands_app/BottomNavigation/bottom_navigation.dart';
import 'package:brands_app/BottomNavigation/AddVideo/add_video.dart';
import 'package:brands_app/BottomNavigation/AddVideo/add_video_filter.dart';
import 'package:brands_app/BottomNavigation/MyProfile/followers.dart';
import 'package:brands_app/BottomNavigation/MyProfile/help_page.dart';
import 'package:brands_app/BottomNavigation/AddVideo/post_info.dart';
import 'package:brands_app/BottomNavigation/Explore/search_users.dart';
import 'package:brands_app/BottomNavigation/MyProfile/tnc.dart';
import 'package:brands_app/Chat/chat_page.dart';
import 'package:brands_app/Screens/user_profile.dart';

import '../Auth/Registration/UI/register_page.dart';
import '../Auth/Registration/register.dart';
import '../Auth/Registration/registercompany.dart';
import '../stteper/company_stteper.dart';
import '../stteper/stteper_demo.dart';

class PageRoutes {
  static const String loginNavigator = 'login_navigator';
  static const String bottomNavigation = 'bottom_navigation';
  static const String followersPage = 'followers_page';
  static const String helpPage = 'help_page';
  static const String tncPage = 'tnc_page';
  static const String searchPage = 'search_page';
  static const String addVideoPage = 'add_video_page';
  static const String addVideoFilterPage = 'add_video_filter_page';
  static const String postInfoPage = 'post_info_page';
  static const String userProfilePage = 'user_profile_page';
  static const String chatPage = 'chat_page';
  static const String morePage = 'more_page';
  static const String videoOptionPage = 'video_option_page';
  static const String verifiedBadgePage = 'verified_badge_page';
  static const String languagePage = 'language_page';
  static const String loginpage = 'login_page';
  static const String signuppage = 'signup_page';
  static const String stepper = 'stepper_page';
  static const String stepperCompany = 'stepperCompany_page';
  static const String registerUser = 'registerUser_page';
  static const String registerCompany = 'registerCompany_page';

  Map<String, WidgetBuilder> routes() {
    return {
      loginNavigator: (context) => LoginNavigator(),
      registerCompany: (context) => RegisterCompany(),
      registerUser: (context) => Register(),
      stepperCompany: (context) => StepperCompany(),
      stepper: (context) => StepperDemo(),
      signuppage: (context) => RegisterPage(),
      loginpage: (context) => LoginPage(),
      bottomNavigation: (
        context,
      ) =>
          BottomNavigation(),
      followersPage: (context) => FollowersPage(),
      helpPage: (context) => HelpPage(),
      tncPage: (context) => TnC(),
      searchPage: (context) => SearchUsers(),
      addVideoPage: (context) => AddVideo(),
      addVideoFilterPage: (context) => AddVideoFilter(),
      postInfoPage: (context) => PostInfo(),
      userProfilePage: (context) => UserProfilePage(),
      chatPage: (context) => ChatPage(),
      morePage: (context) => MorePage(),
      videoOptionPage: (context) => VideoOptionPage(),
      verifiedBadgePage: (context) => BadgeRequest(),
      languagePage: (context) => ChangeLanguagePage(),
    };
  }
}
