import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_app/core/theme/appTheme.dart';

class PaymentButton extends StatelessWidget {
  final String chosenMethod;
  final List<String> paymentMethods;
  final Function(String) callback;

  const PaymentButton({this.chosenMethod, this.paymentMethods, this.callback});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 20.w),
            child: Text('Оплата', style: AppFontStyles.mediumSubTitle),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 6.h),
            width: MediaQuery.of(context).size.width - 50.w,
            decoration: BoxDecoration(color: AppColors.grey, boxShadow: [
              BoxShadow(
                  color: Colors.grey[300],
                  spreadRadius: 3,
                  blurRadius: 4,
                  offset: Offset(1, 1))
            ]),
            child: DropdownButton<String>(
              isExpanded: true,
              value: chosenMethod,
              underline: SizedBox.shrink(),
              dropdownColor: AppColors.grey,
              onChanged: callback,
              icon: Icon(Icons.arrow_forward_ios_outlined,
                  size: 12.sp, color: AppColors.black),
              items:
                  paymentMethods.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, style: AppFontStyles.mediumTitle(true)),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
