import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoadingOrder extends StatelessWidget {
  final String text;

  const LoadingOrder({this.text});

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;

    return Center(
      child: Column(
        children: [
          SizedBox(height: _height / 4),
          CircularProgressIndicator(),
          SizedBox(height: 14.h),
          Text(text),
        ],
      ),
    );
  }
}
