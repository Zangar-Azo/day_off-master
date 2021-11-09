import 'package:flutter/material.dart';
import 'package:new_app/core/theme/appTheme.dart';

class BottomBarItem extends StatelessWidget {
  final IconData icon;
  final Function onPressed;

  const BottomBarItem({this.icon, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 12, right: 12, bottom: 20, top: 10),
      child: IconButton(
        icon: Icon(
          icon,
          color: AppColors.yellow,
          size: 34,
        ),
        onPressed: onPressed,
      ),
    );
  }
}
