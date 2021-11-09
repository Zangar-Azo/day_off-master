import 'package:flutter/material.dart';
import 'package:new_app/core/config/routes.dart';
import 'package:new_app/core/theme/appTheme.dart';
import 'package:new_app/core/widgets/buttons/button.dart';
import 'package:new_app/modules/home/views/topItems/top_part.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderDetailsView extends StatefulWidget {
  @override
  _OrderDetailsViewState createState() => _OrderDetailsViewState();
}

class _OrderDetailsViewState extends State<OrderDetailsView> {
  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                height: _height,
                color: Colors.black.withOpacity(0.7),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 50.h, horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TopPart(title: 'Статус заказа', revert: true),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              top: 40.h, left: 50.w, right: 50.w),
                          child: Column(
                            children: [
                              isFinishedCircle(finished: true, title: 'Принят'),
                              Transform.translate(
                                offset: Offset(0, -3.h),
                                child: Column(
                                  children: [
                                    lineProgress(100, 50),
                                    isFinishedCircle(
                                        finished: false, title: 'Готовиться'),
                                    lineProgress(100, 0),
                                    isFinishedCircle(
                                        finished: false,
                                        title: 'В пути',
                                        hint: 'Осталось 14:14'),
                                    lineProgress(100, 0),
                                    isFinishedCircle(
                                        finished: false,
                                        title: 'Заказ будет у Вас через',
                                        hint: ' 14:14',
                                        last: true),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: _height / 4),
                        CustomButton(
                          title: 'Свернуть статус',
                          onTap: () {
                            Navigator.pushNamed(context, Routes.HOME);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget isFinishedCircle(
      {bool finished, String title, String hint, bool last = false}) {
    return Stack(
      alignment: Alignment.centerLeft,
      clipBehavior: Clip.none,
      children: [
        finished
            ? Icon(Icons.check_circle, color: AppColors.yellow, size: 36.sp)
            : Container(
                width: 30.sp,
                height: 30.sp,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: AppColors.darkGrey),
              ),
        Positioned(
            right: -300.w,
            top: 6.h,
            left: 50.w,
            child: last
                ? Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: title,
                          style: finished
                              ? AppFontStyles.white14w500
                              : AppFontStyles.white14w300,
                        ),
                        TextSpan(
                            text: hint,
                            style: TextStyle(
                                color: AppColors.yellow, fontSize: 12.sp))
                      ],
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        textAlign: TextAlign.start,
                        style: finished
                            ? AppFontStyles.white14w500
                            : AppFontStyles.white14w300,
                      ),
                      hint != null
                          ? Text(
                              hint,
                              style: TextStyle(
                                  color: AppColors.yellow, fontSize: 10.sp),
                            )
                          : Container(),
                    ],
                  )),
      ],
    );
  }

  Widget lineProgress(int total, int current) {
    return Column(
      children: [
        Container(
            height: 55.h * current / total,
            width: 2.w,
            color: AppColors.yellow),
        Container(
            height: 55.h * (1 - current / total),
            width: 2.w,
            color: AppColors.darkGrey),
      ],
    );
  }
}

enum Type {
  checkpoint,
  line,
}

class Step {
  Step({
    this.type,
    this.hour,
    this.message,
    this.duration,
    this.color,
    this.finished = false,
  });

  final Type type;
  final String hour;
  final String message;
  final int duration;
  final Color color;
  final bool finished;

  bool get isCheckpoint => type == Type.checkpoint;

  bool get hasHour => hour != null && hour.isNotEmpty;
}
