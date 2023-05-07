import 'dart:io';

import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';
import 'package:brands_app/Components/continue_button.dart';
import 'package:brands_app/Components/entry_field.dart';
import 'package:brands_app/Locale/locale.dart';
import 'package:brands_app/Theme/colors.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../Routes/routes.dart';
import '../../login_navigator.dart';

//register page for registration of a new user
class RegisterPage extends StatefulWidget {
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _obscureText = true;
  late bool individual;
  IconData _iconVisible = Icons.visibility_off;

  Color _backgroundColor = Color(0xFFE43F3F);
  Color _underlineColor = Color(0xFFCCCCCC);
  Color _buttonColor = Color(0xFFCC1D1D);

  Widget CustomRadioButton(String text, int index, IconData Iconsu) {
    return Container(
      width: 300.0,
      height: 50.0,
      child: OutlinedButton.icon(
          onPressed: () {
            setState(() {
              value = index;
              if (index == 2) {
                individual = false;
              } else {
                individual = true;
              }

              print(value);
              print(individual);
            });
          },
          style: OutlinedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            side: BorderSide(
                width: 2,
                color: (value != index)
                    ? Color.fromARGB(255, 0, 0, 0)
                    : Color.fromARGB(255, 226, 234, 227)),
          ),
          icon: Icon(Iconsu,
              color: (value != index)
                  ? Color.fromARGB(255, 0, 0, 0)
                  : Color.fromARGB(255, 226, 234, 227),
              size: (value != index) ? 30.0 : 40.0),
          label: Text(
            text,
            style: TextStyle(
                color: (value == index)
                    ? Color.fromARGB(255, 240, 248, 240)
                    : Color.fromARGB(255, 0, 0, 0),
                fontSize: 30),
          )),
    );
  }

  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
      if (_obscureText == true) {
        _iconVisible = Icons.visibility_off;
      } else {
        _iconVisible = Icons.visibility;
      }
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  int value = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: Platform.isIOS
            ? SystemUiOverlayStyle.light
            : SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light),
        child: ListView(
          padding: EdgeInsets.fromLTRB(32, 32, 32, 24),
          children: [
            Container(
              child: Image.asset('assets/images/logo_dark.png', height: 120),
            ),
            SizedBox(
              height: 30,
            ),
            Column(
              children: <Widget>[
                CustomRadioButton("USERS", 1, Icons.supervised_user_circle),
                SizedBox(
                  height: 20,
                ),
                CustomRadioButton("COMPANY", 2, Icons.account_balance),
              ],
            ),
            SizedBox(
              height: 100,
            ),
            ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) => _buttonColor,
                  ),
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3.0),
                  )),
                ),
                onPressed: () {
                  Fluttertoast.showToast(
                      msg: 'Click create account',
                      toastLength: Toast.LENGTH_SHORT);
                  if (individual) {
                    Navigator.pushNamed(context, PageRoutes.registerUser);
                  } else {
                    Navigator.pushNamed(context, PageRoutes.registerCompany);
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Text(
                    AppLocalizations.of(context)!.signup!,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                )),
            SizedBox(
              height: 32,
            ),
            Center(
              child: GestureDetector(
                onTap: () {
                  Fluttertoast.showToast(
                      msg: 'Click signin', toastLength: Toast.LENGTH_SHORT);
                  Navigator.pop(context);
                },
                child: Text(AppLocalizations.of(context)!.alredymember!,
                    style: TextStyle(fontSize: 15, color: Colors.white)),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
