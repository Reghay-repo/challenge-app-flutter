import 'package:brands_app/provider/authProvider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:brands_app/BottomNavigation/MyProfile/language_page.dart';
import 'package:brands_app/Locale/locale.dart';
import 'package:brands_app/Routes/routes.dart';
import 'package:brands_app/Theme/style.dart';
import 'package:firebase_core/firebase_core.dart';

import 'Auth/Login/UI/login_page.dart';
import 'Locale/language_cubit.dart';
import 'package:provider/provider.dart';

import 'Screens/auth_fire.dart';

Future<void> main() async {
  await Future.delayed(const Duration(seconds: 2))
      .then((value) => FlutterNativeSplash.remove());
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ChangeNotifierProvider(
    create: (_) => Auth(),
    child: Phoenix(
        child: BlocProvider(
      create: (context) => LanguageCubit(),
      child: Qvid(),
    )),
  ));
}

class Qvid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        AppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
      ],
      theme: appTheme,
      home: AuthPage(),
      routes: PageRoutes().routes(),
    );
  }
}
