import 'package:flutter/material.dart';
import 'package:new_app/core/theme/appTheme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ItemContainer extends StatelessWidget {
  final String price;
  final String itemType;
  final String itemName;
  final String imgAsset;
  final bool revert;
  final Color color;

  const ItemContainer(
      {Key key,
      this.price,
      this.itemType,
      this.itemName,
      this.revert,
      this.imgAsset,
      this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: 15.h,
            left: -20.w,
            right: -20.w,
            bottom: 25.h,
            child: Container(
              color: color,
              height: 160.h,
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 10.h,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(width: 10.w),
                Image.asset(
                  imgAsset,
                  width: 70.w,
                  height: 220.h,
                ),
                SizedBox(width: 30.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 60.h),
                      Text(itemType, style: AppFontStyles.mediumSubTitle),
                      Flexible(
                          child: Text(itemName,
                              style: AppFontStyles.mediumTitle(revert))),
                      SizedBox(height: 30.h),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("$price\t",
                              style: AppFontStyles.bigTitle(revert)),
                          Text(' ТГ',
                              textAlign: TextAlign.start,
                              style: AppFontStyles.bigSubTitle)
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 40.h,
            right: 15,
            child: Icon(
              Icons.favorite_outline,
              size: 16,
              color: revert ? AppColors.black : AppColors.yellow,
            ),
          )
        ],
      ),
    );
  }
}
