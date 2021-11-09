import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class AppColors {
  static get primary => Colors.white;
  static get black => Color(0xFF181818);
  static get yellow => Color(0xFFEFE412);
  static get grey => Color(0xFFEDEDED);
  static get darkGrey => Color(0xFF6A6D6D);
  static get yellowAccent => Color(0xF7FAEE0C);
}

abstract class AppFontStyles {
  // Header Style
  static get headingBlackSpacing => TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w500,
        fontSize: 20.sp,
        letterSpacing: 4,
      );

  static get mediumSubTitle => TextStyle(
        fontSize: 12.sp,
        color: Colors.grey[600],
      );

  static mediumTitle(bool revert) => TextStyle(
        color: revert ? AppColors.black : AppColors.yellow,
        fontSize: 14.sp,
        fontWeight: FontWeight.w700,
      );

  static bigTitle(bool revert) => TextStyle(
        color: revert ? AppColors.black : AppColors.yellow,
        fontWeight: FontWeight.w700,
        fontSize: 17.sp,
      );

  static get bigSubTitle => TextStyle(
        color: AppColors.darkGrey,
        fontSize: 8.sp,
      );

  // Normal Text Style
  static get headerMediumStyle => TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w500,
        fontSize: 15,
      );

  static get black14w300 => TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w300,
        fontSize: 16.sp,
      );

  static get black12w300 => TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w300,
        fontSize: 12.sp,
      );

  static get black12w700 => TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w700,
        fontSize: 12.sp,
      );

  static get yellow16w700 => TextStyle(
        color: AppColors.yellow,
        fontWeight: FontWeight.w700,
        fontSize: 16.sp,
      );
  static get yellow16w400 => TextStyle(
        color: AppColors.yellow,
        fontWeight: FontWeight.w300,
        fontSize: 16.sp,
      );

  // Action Button Style
  static get black14w400 => TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w400,
        fontSize: 16.sp,
      );
  static get black10w400 => TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w400,
        fontSize: 10.sp,
      );

  static get black8w300 => TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w300,
        fontSize: 8.sp,
      );

  static get white12w400 => TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w400,
        fontSize: 12.sp,
      );

  static get white14w300 => TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w300,
        fontSize: 14.sp,
      );

  static get white14w500 => TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w500,
        fontSize: 14.sp,
      );
}

abstract class AppTheme {
  static get light => ThemeData(
        primaryColor: AppColors.black,
        accentColor: AppColors.yellow,
        backgroundColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
        highlightColor: Colors.white24,
        fontFamily: 'MyriadSetPro',
        bottomAppBarTheme: BottomAppBarTheme(
          color: Colors.white,
        ),
        appBarTheme: AppBarTheme(color: AppColors.black),
        textTheme: TextTheme(
            bodyText1: TextStyle(
                color: Colors.black, fontWeight: FontWeight.w400, fontSize: 14),
            headline2: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w400,
                fontSize: 20)),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          elevation: 4,
          // selectedIconTheme: IconThemeData(
          //   color: AppColors.iconSelected,
          // ),
        ),
      );
}

abstract class AppGradinets {
  static get mainButtonGradient => LinearGradient(colors: [
        Color(
          0xff396FB4,
        ),
        Color(0xff8F4BCF),
      ], begin: Alignment.centerLeft, end: Alignment.centerRight);
}

abstract class AppContainerDecoration {
  static get buttonGradinetDec => BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(colors: [
          Color(0xffD010FF),
          Color(0xff5A0E99),
        ], begin: Alignment.topLeft, end: Alignment.bottomRight),
      );
}
