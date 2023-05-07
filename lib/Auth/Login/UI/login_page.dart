import 'dart:io';

import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:brands_app/Auth/login_navigator.dart';
import 'package:brands_app/Components/continue_button.dart';
import 'package:brands_app/Components/entry_field.dart';
import 'package:brands_app/Locale/locale.dart';
import 'package:brands_app/Theme/colors.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../../../Routes/routes.dart';
import '../../../provider/authProvider.dart';
import 'package:restart_app/restart_app.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LoginBody();
  }
}

class LoginBody extends StatefulWidget {
  @override
  _LoginBodyState createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  bool _obscureText = true;
  IconData _iconVisible = Icons.visibility_off;

  Color _backgroundColor = Color(0xFFE43F3F);
  Color _underlineColor = Color(0xFFCCCCCC);
  Color _buttonColor = Color(0xFFCC1D1D);

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
    emailController.dispose();
    passwordController.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late bool _success;
  late String _userEmail;
  void submit() {
    Provider.of<Auth>(context, listen: false).login(cendentials: {
      'email': emailController,
      'password': passwordController,
    });
    Navigator.pop(context);
  }

  final user = FirebaseAuth.instance.currentUser;
  Future signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
      await user!.photoURL.toString() != null;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('login succes')),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No user found for that email')),
        );
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Wrong password provided for that user')),
        );
      }
    }
  }

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
        child: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.fromLTRB(32, 72, 32, 24),
            children: [
              Container(
                child: Image.asset('assets/images/logo_dark.png', height: 120),
              ),
              SizedBox(
                height: 32,
              ),
              TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                  controller: emailController,
                  decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 2.0)),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: _underlineColor),
                      ),
                      labelText: AppLocalizations.of(context)!.email!,
                      labelStyle: TextStyle(color: Colors.white)),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  }),
              SizedBox(
                height: 24,
              ),
              TextFormField(
                obscureText: _obscureText,
                style: TextStyle(color: Colors.white),
                cursorColor: Colors.white,
                controller: passwordController,
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2.0)),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: _underlineColor),
                  ),
                  labelText: AppLocalizations.of(context)!.password!,
                  labelStyle: TextStyle(color: Colors.white),
                  suffixIcon: IconButton(
                      icon: Icon(_iconVisible, color: Colors.white, size: 20),
                      onPressed: () {
                        _toggleObscureText();
                      }),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 24,
              ),
              GestureDetector(
                onTap: () {
                  Fluttertoast.showToast(
                      msg: 'Click forgot password',
                      toastLength: Toast.LENGTH_SHORT);
                },
                child: Text(AppLocalizations.of(context)!.forgotpassword!,
                    style: TextStyle(color: Colors.white, fontSize: 13),
                    textAlign: TextAlign.right),
              ),
              SizedBox(
                height: 40,
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
                    if (_formKey.currentState!.validate()) {
                      signIn();

                      print("he re : $passwordController");
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please fill input')),
                      );
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Text(
                      AppLocalizations.of(context)!.login!,
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
                child: Text(AppLocalizations.of(context)!.orContinueWith!,
                    style: TextStyle(fontSize: 15, color: Colors.white)),
              ),
              SizedBox(
                height: 32,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Fluttertoast.showToast(
                            msg: 'Signin with google',
                            toastLength: Toast.LENGTH_SHORT);
                      },
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                        ),
                        child: Image(
                          image: AssetImage('assets/images/google.png'),
                          width: 24,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Fluttertoast.showToast(
                            msg: 'Signin with facebook',
                            toastLength: Toast.LENGTH_SHORT);
                      },
                      child: Image(
                          image: AssetImage('assets/images/facebook.png'),
                          width: 40,
                          color: Colors.white),
                    ),
                    GestureDetector(
                      onTap: () {
                        Fluttertoast.showToast(
                            msg: 'Signin with twitter',
                            toastLength: Toast.LENGTH_SHORT);
                      },
                      child: Image(
                          image: AssetImage('assets/images/twitter.png'),
                          width: 40,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 60,
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    Fluttertoast.showToast(
                        msg: 'Click signup', toastLength: Toast.LENGTH_SHORT);
                    Navigator.pushNamed(context, PageRoutes.signuppage);
                  },
                  child: Text(AppLocalizations.of(context)!.signUpNow!,
                      style: TextStyle(fontSize: 15, color: Colors.white)),
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
