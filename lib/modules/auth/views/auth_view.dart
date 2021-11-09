import 'package:flutter/material.dart';
import 'package:new_app/core/config/routes.dart';

import 'package:new_app/core/provider/auth/controller/auth_service.dart';
import 'package:new_app/core/theme/appTheme.dart';
import 'package:new_app/modules/auth/widgets/modals/check_code_modal.dart';
import 'package:new_app/modules/auth/widgets/modals/send_code_modal.dart';
import 'package:provider/provider.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthView extends StatefulWidget {
  @override
  _AuthViewState createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  bool _clicked = false;
  String _phone = '';
  String _code = '';
  
  @override
  Widget build(BuildContext context) {
    final _authService = context.read<AuthController>();

    return Padding(
      padding: const EdgeInsets.only(top: 14),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Padding(
            padding:
                EdgeInsets.only(left: 20.w, top: 12.w, bottom: 20.h, right: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      color: AppColors.yellow,
                      width: 85,
                      height: 1,
                    ),
                    Text(
                      "ПРОФИЛЬ",
                      style: TextStyle(color: AppColors.yellow, letterSpacing: 12, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      color: AppColors.yellow,
                      width: 85,
                      height: 1,
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "Оставьте\nсвой номер телефона",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  color: Color(0xFFFFD800),
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  height: 60,
                  alignment: Alignment.bottomCenter,
                  child: Center(
                    child: TextButton(
                      child: Text(
                        'Указать телефон',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      onPressed: () => onPressed(_authService),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> onPressed(AuthController _authService) async {
    await showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            contentPadding:
                EdgeInsets.only(top: 26, left: 12, right: 12, bottom: 14),
            content: StatefulBuilder(
                builder: (_, StateSetter setState) => !_clicked
                    ? SendCodeModal(
                        callback: () {
                          setState(() {
                            _clicked = true;
                            _phone = "";
                          });

                          _authService.sendCode(_phone);
                        },
                      )
                    : CheckCodeModal(
                        callback: () {
                          _authService.login(_phone, _code);
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              Routes.HOME, (route) => false);
                        },
                        phone: _phone,
                      )),
          );
        });
  }
}
