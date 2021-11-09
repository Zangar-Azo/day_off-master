import 'package:flutter/material.dart';
import 'package:new_app/core/provider/auth/controller/auth_service.dart';
import 'package:new_app/core/theme/appTheme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_app/core/widgets/bottomBar/bottomBar.dart';
import 'package:new_app/modules/auth/views/auth_view.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  bool entered = false;

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _authService = context.watch<AuthController>();
    final userLoaded = _authService.state == ViewState.UserLoaded;
    if (userLoaded) entered = true;
    print(_authService.state);

    return Scaffold(
      backgroundColor: AppColors.black,
      body: entered
          ? AuthView()
          : SafeArea(
              child: Center(
                child: Image.asset(
                  'assets/icons/logo1.png',
                  width: _width - 100.w,
                ),
              ),
            ),
      // bottomNavigationBar: entered ? CustomBottomBar() : null,
    );
  }
}
