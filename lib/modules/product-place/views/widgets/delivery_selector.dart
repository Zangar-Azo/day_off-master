import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_app/core/theme/appTheme.dart';
import 'package:new_app/core/widgets/buttons/buttonToPop.dart';

class DeliverySelectorView extends StatelessWidget {
  final Function(String) callback;
  DeliverySelectorView({this.callback});

  List<String> list = ['Курьер', 'Самовывоз'];
  List<String> listPrices = ['500', '0'];
  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text('Выберите курьерскую службу:',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 14.sp,
                          )),
                    ),
                    ButtonToPop(),
                  ],
                ),
                SizedBox(height: 20.h),
                ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (_, i) => GestureDetector(
                    onTap: () {
                      callback(list[i]);
                      Navigator.pop(context);
                      print(list[i]);
                    },
                    child: Container(
                      padding: EdgeInsets.all(20.sp),
                      height: 80.h,
                      decoration: BoxDecoration(
                          color: AppColors.black,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black38,
                                spreadRadius: 2,
                                blurRadius: 8)
                          ]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(list[i],
                              style: TextStyle(
                                color: AppColors.yellow,
                                fontSize: 14.sp,
                              )),
                          Row(
                            children: [
                              Text(listPrices[i],
                                  style: AppFontStyles.yellow16w700),
                              Text('\tТГ', style: AppFontStyles.bigSubTitle),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  separatorBuilder: (_, __) => SizedBox(height: 15.h),
                  itemCount: list.length,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
