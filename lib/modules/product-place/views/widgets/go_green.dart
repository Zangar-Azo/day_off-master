import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_app/core/theme/appTheme.dart';

class GoGreenContainer extends StatelessWidget {
  final bool enable;
  final Function callback;

  const GoGreenContainer({Key key, this.enable, this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 8.w),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(color: Colors.grey[200], spreadRadius: 6, blurRadius: 6)
        ],
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 14.w),
                child: SvgPicture.asset('assets/icons/recycle_icon.svg',
                    height: 28.h),
              ),
              Text('GoGreen\t', style: AppFontStyles.mediumTitle(true)),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('199',
                      style: TextStyle(
                          color: Colors.greenAccent[400],
                          fontWeight: FontWeight.w700,
                          fontSize: 14.sp)),
                  Text('\tТГ',
                      style: TextStyle(
                          color: Colors.greenAccent[400],
                          fontWeight: FontWeight.w700,
                          fontSize: 7.sp)),
                ],
              ),
            ],
          ),
          Switch(
            value: enable,
            onChanged: callback,
          )
        ],
      ),
    );
  }
}
