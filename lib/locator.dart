import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';
import 'package:new_app/core/config/auth_config.dart';
import 'package:new_app/api/repository.dart';
import 'package:new_app/core/config/notifications.dart';
import 'package:new_app/core/provider/auth/controller/auth_service.dart';
import 'package:new_app/core/provider/auth/local_data_sources/auth_local_ds.dart';
import 'package:new_app/core/services/network/network.dart';
import 'package:new_app/modules/home/controllers/category_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

import 'core/config/application.dart';
import 'core/config/firebase_messaging.dart';
import 'modules/product-place/views/controller/CartController.dart';
import 'modules/product-place/views/controller/google_map_controller.dart';

final sl = GetIt.asNewInstance();

Future<void> setupLocator() async {
  // UI
  sl.registerLazySingleton(() => Application());

  // auth services
  sl.registerLazySingleton<AuthController>(() => AuthController(
      api: sl<GlobalRepository>(), authConfig: sl<AuthConfig>()));

  // category services
  sl.registerLazySingleton<CategoryController>(
      () => CategoryController(api: sl<GlobalRepository>()));

  // cart services
  sl.registerLazySingleton<CartController>(
      () => CartController(api: sl<GlobalRepository>()));

  // api
  sl.registerLazySingleton<GlobalRepository>(() => GlobalRepository(
      client: sl(),
      networkInfo: sl<NetworkInfo>(),
      authLocalDataSource: sl<AuthLocalDataSource>()));

  // local storage
  final prefs = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => prefs);

  // network online/offline
  sl.registerLazySingleton(() => DataConnectionChecker());

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  sl.registerLazySingleton(() => http.Client());

  // repositories

  // data sources
  sl.registerLazySingleton<AuthLocalDataSource>(
      () => AuthLocalDataSourceImpl());

  // user info
  sl.registerLazySingleton<AuthConfig>(() => AuthConfig());

  // Notification handler

  sl.registerLazySingleton<NotificationHandler>(
      () => NotificationHandler(FlutterLocalNotificationsPlugin()));

  sl.registerLazySingleton<FirebaseMessagingNotification>(
      () => FirebaseMessagingNotification());

  // Google map services
  sl.registerLazySingleton<GeolocationService>(
      () => GeolocationService(client: sl(), networkInfo: sl<NetworkInfo>()));
}
