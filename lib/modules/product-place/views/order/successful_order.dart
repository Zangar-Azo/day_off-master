import 'package:flutter/material.dart';
import 'package:new_app/core/config/routes.dart';
import 'package:new_app/core/theme/appTheme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_app/core/widgets/buttons/button.dart';

class SuccessOrderView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;

    return Center(
      child: Column(
        children: [
          SizedBox(height: _height / 3),
          Icon(Icons.check_circle_outline_outlined,
              color: AppColors.yellow, size: 54.sp),
          SizedBox(height: 20.h),
          Text(
            'Ваш зака принят.\nНомер заказа: 12383',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24.sp),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10.h),
          Text('Вы можете отследить свой заказ'),
          SizedBox(height: _height / 4),
          CustomButton(
            title: 'Следить за заказом',
            revert: false,
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, Routes.ORDER_DETAILS_VIEW, (route) => false);
            },
          ),
        ],
      ),
    );
  }
}
