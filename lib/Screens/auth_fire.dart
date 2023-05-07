import 'package:brands_app/Auth/Login/UI/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../BottomNavigation/bottom_navigation.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: ((context, snapshot) {
            if (snapshot.hasData) {
              print("login succes");
              print(snapshot.hasData);
              return BottomNavigation();
            } else {
              return LoginPage();
            }
          })),
    );
  }
}
