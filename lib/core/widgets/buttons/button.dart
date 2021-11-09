import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_app/core/theme/appTheme.dart';

class CustomButton extends StatelessWidget {
  final Function onTap;
  final String title;
  final bool revert;

  const CustomButton({Key key, this.onTap, this.title, this.revert = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    return TextButton(
      style: TextButton.styleFrom(
          padding: EdgeInsets.all(20.sp),
          backgroundColor: revert ? AppColors.yellow : AppColors.black,
          minimumSize: Size(_width - 50.w, 50.h)),
      onPressed: onTap,
      child: Text(title, style: AppFontStyles.mediumTitle(revert)),
    );
  }
}
