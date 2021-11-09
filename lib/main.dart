import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_app/core/config/firebase_messaging.dart';
import 'package:new_app/core/config/notifications.dart';
import 'package:new_app/core/config/routes.dart';
import 'package:new_app/core/provider/auth/controller/auth_service.dart';
import 'package:new_app/core/theme/appTheme.dart';
import 'package:new_app/locator.dart';
import 'package:new_app/modules/product-place/views/controller/CartController.dart';
import 'package:provider/provider.dart';

import 'modules/home/controllers/category_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();

  // init Firebase App
  await Firebase.initializeApp();

  await sl<NotificationHandler>().initNotification();

  // initialize FirebaseMessaging
  await sl<FirebaseMessagingNotification>().registerNotification();

  runApp(ScreenUtilInit(
    designSize: Size(360, 690),
    builder: () => MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthController>.value(
            value: sl<AuthController>()),
        ChangeNotifierProvider<CategoryController>.value(
            value: sl<CategoryController>()),
        ChangeNotifierProvider<CartController>.value(
            value: sl<CartController>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        title: 'Flutter Demo',
        routes: routes,
        initialRoute: Routes.HOME,
      ),
    );
  }
}
