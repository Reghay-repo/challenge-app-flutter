import 'dart:io';

import 'package:brands_app/Auth/login_navigator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../BottomNavigation/bottom_navigation.dart';
import '../../Locale/locale.dart';
import '../../Routes/routes.dart';
import '../../Screens/auth_fire.dart';

class Register extends StatefulWidget {
  const Register({super.key, this.typeUser});
  final typeUser;
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool _obscureText = true;
  IconData _iconVisible = Icons.visibility_off;
  User? user;
  Color _backgroundColor = Color(0xFFE43F3F);
  Color _underlineColor = Color(0xFFCCCCCC);
  Color _buttonColor = Color(0xFFCC1D1D);
  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    nameCompanyController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmePasswordController.dispose();
  }

  Future getData() async {
    final ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.child('users').get();
    if (snapshot.exists) {
      print(snapshot.value);
    } else {
      print('No data available.');
    }
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

  Future signUp() async {
    try {
      if (passwordConfirmed()) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim());
        final user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          // Name, email address, and profile photo URL
          final name = user.displayName;
          final email = user.email;
          final photoUrl = user.photoURL;

          // Check if user's email is verified
          final emailVerified = user.emailVerified;
          final uid = user.uid;
          var userInfo =
              FirebaseFirestore.instance.collection('users').doc(user.uid).set({
            "email": user.email,
            "name": nameCompanyController.text.trim(),
            "phone": phoneController.text.trim(),
            "typeUser": "user",
          });
        }
        await user?.updateDisplayName(nameCompanyController.text.trim());

        await user
            ?.updatePhotoURL("https://example.com/jane-q-user/profile.jpg");
        Navigator.pop(context);
        Navigator.pop(context);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('The password is too short')),
        );
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('The account already exists for that email')),
        );
      }
    } catch (e) {
      print(e);
    }
  }

  bool passwordConfirmed() {
    if (confirmePasswordController.text.trim() ==
        passwordController.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameCompanyController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmePasswordController = TextEditingController();
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
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Name is required';
                  }
                  return null;
                },
                controller: nameCompanyController,
                keyboardType: TextInputType.text,
                style: TextStyle(color: Colors.white),
                cursorColor: Colors.white,
                decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.white, width: 2.0)),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: _underlineColor),
                    ),
                    labelText: AppLocalizations.of(context)!.fullName!,
                    labelStyle: TextStyle(color: Colors.white)),
              ),
              SizedBox(
                height: 24,
              ),
              TextFormField(
                controller: phoneController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'telephone is required';
                  }
                  return null;
                },
                keyboardType: TextInputType.phone,
                style: TextStyle(color: Colors.white),
                cursorColor: Colors.white,
                decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.white, width: 2.0)),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: _underlineColor),
                    ),
                    labelText: AppLocalizations.of(context)!.phoneNumber!,
                    labelStyle: TextStyle(color: Colors.white)),
              ),
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
              TextFormField(
                obscureText: _obscureText,
                style: TextStyle(color: Colors.white),
                cursorColor: Colors.white,
                controller: confirmePasswordController,
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2.0)),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: _underlineColor),
                  ),
                  labelText: 'Confirm password',
                  labelStyle: TextStyle(color: Colors.white),
                  suffixIcon: IconButton(
                      icon: Icon(_iconVisible, color: Colors.white, size: 20),
                      onPressed: () {
                        _toggleObscureText();
                      }),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please confirm your password';
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
                      signUp();
                      getData();

                      print("he re : $confirmePasswordController");
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please fill input')),
                      );
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
              SizedBox(
                height: 60,
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
