import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';
import 'package:brands_app/Auth/login_navigator.dart';
import 'package:brands_app/Components/continue_button.dart';
import 'package:brands_app/Components/entry_field.dart';
import 'package:brands_app/Locale/locale.dart';
import 'package:brands_app/Theme/colors.dart';

class SocialLogin extends StatefulWidget {
  @override
  _SocialLoginState createState() => _SocialLoginState();
}

class _SocialLoginState extends State<SocialLogin> {
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(140.0),
        child: AppBar(
          flexibleSpace: Column(
            children: <Widget>[
              Spacer(),
              CircleAvatar(
                backgroundImage: AssetImage('assets/images/user.webp'),
                radius: 40,
              ),
              Text(
                '\n${locale.changeProfilePic!}',
                style: TextStyle(color: disabledTextColor),
              ),
            ],
          ),
        ),
      ),
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
        child: FadedSlideAnimation(
          beginOffset: Offset(0, 0.3),
          endOffset: Offset(0, 0),
          slideCurve: Curves.linearToEaseOut,
          child: Padding(
            padding: EdgeInsets.only(left: 20.0, bottom: 16.0, right: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text(
                    locale.comment6!,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 12.0),
                EntryField(
                  label: AppLocalizations.of(context)!.phoneNumber,
                  initialValue: "+919876543210",
                  keyboardType: TextInputType.number,
                ),
                Spacer(),
                CustomButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, LoginRoutes.verification),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
