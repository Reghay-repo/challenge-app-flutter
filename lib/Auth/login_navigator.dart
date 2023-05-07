import 'package:flutter/material.dart';
import 'package:brands_app/Auth/Login/UI/login_page.dart';
import 'package:brands_app/Auth/Registration/UI/register_page.dart';
import 'package:brands_app/Auth/SocialLogin/social_login.dart';
import 'package:brands_app/Auth/Verification/UI/verification_page.dart';
import 'package:brands_app/Routes/routes.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class LoginRoutes {
  static const String loginRoot = 'login/';
  static const String registration = 'login/registration';
  static const String verification = 'login/verification';
  static const String socialLogin = 'login/social_login';
}

class LoginNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        var canPop = navigatorKey.currentState!.canPop();
        if (canPop) {
          navigatorKey.currentState!.pop();
        }
        return !canPop;
      },
      child: Navigator(
        key: navigatorKey,
        initialRoute: LoginRoutes.loginRoot,
        onPopPage: (Route<dynamic> route, dynamic result) {
          return route.didPop(result);
        },
      ),
    );
  }
}
