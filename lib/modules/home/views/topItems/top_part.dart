import 'package:flutter/material.dart';
import 'package:new_app/core/theme/appTheme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TopPart extends StatelessWidget {
  final bool revert;
  final String title;

  const TopPart({Key key, this.revert = false, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: FractionallySizedBox(
            widthFactor: 0.8,
            child: Container(
                color: revert ? AppColors.yellow : AppColors.black,
                height: 1.h),
          ),
        ),
        Flexible(
          child: FractionallySizedBox(
            widthFactor: 1.5,
            child: Text(
              title.toUpperCase(),
              textAlign: TextAlign.center,
              style: TextStyle(
                  letterSpacing: 5,
                  color: revert ? AppColors.yellow : AppColors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
        Flexible(
          child: FractionallySizedBox(
            widthFactor: 0.8,
            child: Container(
                color: revert ? AppColors.yellow : AppColors.black,
                height: 1.h),
          ),
        ),
      ],
    );
  }
}
