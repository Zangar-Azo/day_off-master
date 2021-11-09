import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:new_app/core/utils/const.dart';

enum Endpoints {
  // Authentication
  createCode,
  login,
  sendPhone,

  // PROFILE
  getUser,

  // Routes
  getPage,

  // Categories
  getCategories,

  // Products
  getProductsById,
  getProducts,

  // Cart Services
  getCartProducts,
  addToCartORincreaseQuantity,
  deleteFromCart,

  // Favorites
  addToFavorites,
  deleteFromFavorites,
  getFavorites,

  // GoogleMap
  getAutocompleteByInput,
  getAutocompleteByLatLng,

  // Checkout
  checkout,

  //Order
  confirmOrder,
}

const baseURL = "http://dayoff.kz/api.php?route=";

extension EndpointsExtension on Endpoints {
  String path({
    String phone,
    String code,
    String token = "c058e01771f23c435bc61aeafc2986e1",
    String categoryId,
    String page,
    String productId,
    String quantity,
    String input,
    LatLng latLng,
    int radius = 2500,
    String deliveryType,
    bool recall,
    bool contactlessDelivery,
    String comment,
    String address,
    String addressId,
  }) {
    switch (this) {
      case Endpoints.createCode:
        return "$baseURL" + "send_sms&phone=$phone";
      case Endpoints.login:
        return "$baseURL" + "login&phone=$phone&code=$code";
      case Endpoints.getPage:
        return "";
      case Endpoints.getCategories:
        return "$baseURL" + "categories&token=$token";
      case Endpoints.getProductsById:
        return "$baseURL" +
            "get_by_category_id&token=$token&category_id=$categoryId&page=$page";
      case Endpoints.getProducts:
        return "$baseURL" + "products&token=$token&page=$page";
      case Endpoints.getCartProducts:
        return "$baseURL" + "baskets&token=$token";
      case Endpoints.addToCartORincreaseQuantity:
        return "$baseURL" +
            "add_basket&product_id=$productId&quantity=$quantity&token=$token";
      case Endpoints.deleteFromCart:
        return "$baseURL" + "delete_basket&product_id=$productId&token=$token";
      case Endpoints.getFavorites:
        return "$baseURL" + "favorites&token=$token";
      case Endpoints.addToFavorites:
        return "$baseURL" + "add_favorite&product_id=$productId&token=$token";
      case Endpoints.deleteFromFavorites:
        return "$baseURL" +
            "delete_favorite&product_id=$productId&token=$token";
      case Endpoints.getAutocompleteByInput:
        return "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&location=${latLng.latitude},${latLng.longitude}&radius=$radius&key=$GOOGLE_MAPS_API_KEY&components=country:kz";
      case Endpoints.checkout:
        return baseURL +
            "confirm_order&token=$token&delivery_type=$deliveryType&address=$address&comment=$comment&contactless_delivery=$contactlessDelivery&recall=$recall";
      default:
        return "";
    }
  }

  Map<String, String> headers(
      {String token = "c058e01771f23c435bc61aeafc2986e1", Map defaultHeaders}) {
    return Map<String, String>.from({
      if (defaultHeaders != null) ...defaultHeaders,
      if (defaultHeaders == null) ...{'Content-Type': 'application/json'},
      if (token != null && token != '') ...{'Authorization': 'Bearer $token'},
    });
  }
}

