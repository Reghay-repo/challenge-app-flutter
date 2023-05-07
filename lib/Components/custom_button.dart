import 'package:flutter/material.dart';
import 'package:brands_app/Theme/colors.dart';

class CustomButton extends StatelessWidget {
  final Widget icon;
  final String text;
  final Function? onPressed;

  const CustomButton(this.icon, this.text, {this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      splashColor: transparentColor,
      padding: EdgeInsets.symmetric(vertical: 12.0),
      onPressed: onPressed as void Function()?,
      child: Column(
        children: <Widget>[
          icon,
          Text(
            text,
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(color: secondaryColor),
          )
        ],
      ),
    );
  }
}
