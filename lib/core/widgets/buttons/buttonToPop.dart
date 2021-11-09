import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ButtonToPop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Container(
          padding: EdgeInsets.all(10.sp),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(50),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey[350], spreadRadius: 1, blurRadius: 15),
            ],
          ),
          child: RotatedBox(
              quarterTurns: 1, child: Icon(Icons.arrow_forward_ios_rounded))),
    );
  }
}
