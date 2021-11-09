import 'package:flutter/material.dart';
import 'package:new_app/core/app/splash_screen.dart';
import 'package:new_app/modules/home/views/catalog/products.dart';
import 'package:new_app/modules/home/views/home.dart';
import 'package:new_app/modules/order-details/views/order_details.dart';
import 'package:new_app/modules/product-place/views/cart/cart.dart';
import 'package:new_app/modules/product-place/views/order/order.dart';
import 'package:new_app/modules/product-place/views/product_place.dart';

Map<String, WidgetBuilder> routes = {
  Routes.HOME: (_) => Home(),
  Routes.SPLASH_PAGE: (_) => SplashScreen(),
  Routes.PRODUCT_PLACE: (_) => ProductPlaceView(),
  Routes.PRODUCTS_VIEW: (_) => ProductsView(),
  Routes.CART_VIEW: (_) => CartView(),
  Routes.ORDER_VIEW: (_) => OrderView(),
  Routes.ORDER_DETAILS_VIEW: (_) => OrderDetailsView(),
};

class Routes {
  static const HOME = '/home';
  static const SPLASH_PAGE = '/splash';
  static const PRODUCT_PLACE = '/product';
  static const PRODUCTS_VIEW = '/all_products';
  static const CART_VIEW = '/cart';
  static const ORDER_VIEW = '/order';
  static const ORDER_DETAILS_VIEW = '/order_details';
}
