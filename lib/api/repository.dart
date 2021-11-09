import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:new_app/core/errors/failures.dart';
import 'package:new_app/core/provider/auth/local_data_sources/auth_local_ds.dart';
import 'package:new_app/core/provider/auth/models/user_model.dart';
import 'package:new_app/core/services/network/endpoints.dart';
import 'package:new_app/core/services/network/network.dart';
import '../core/utils/http_extension.dart';

class GlobalRepository {
  final http.Client client;
  final NetworkInfo networkInfo;
  final AuthLocalDataSource authLocalDataSource;
  GlobalRepository({this.authLocalDataSource, this.networkInfo, this.client});

  Future<dynamic> createCode(String phone) async {
    print("CREATE CODE");
    if (!await networkInfo.isConnected) return NetworkFailure();

    http.Response response = await client.get(
      Uri.parse(Endpoints.createCode.path(phone: phone)),
      headers: Endpoints.getPage.headers(),
    );

    if (response.isSuccess) {
      var json = jsonDecode(response.body);
      print(json);
      return json['data'];
    }
  }

  Future<UserModel> getUserLocally(String token) async {
    print("RETRIEVE USER LOCALLY");
    var localUser = await authLocalDataSource.getUserLocally('');

    if (localUser != null) {
      return UserModel(phone: '');
    } else
      return UserModel(phone: '');
  }

  Future<dynamic> login(String phone, String code) async {
    print("LOGIN");
    if (!await networkInfo.isConnected) return NetworkFailure();

    http.Response response = await client.get(
      Uri.parse(Endpoints.login.path(phone: phone, code: code)),
      headers: Endpoints.getPage.headers(),
    );
    if (response.isSuccess) {
      var json = jsonDecode(response.body);
      print(json);
      return json['data'];
    }
  }

  Future<dynamic> getCategories(String token) async {
    if (!await networkInfo.isConnected) return NetworkFailure();

    http.Response response = await client.get(
      Uri.parse(Endpoints.getCategories.path()),
      headers: Endpoints.getCategories.headers(),
    );
    if (response.isSuccess) {
      var json = jsonDecode(response.body);
      return json['data']['categories'];
    }
  }

  Future<dynamic> getProductsById(
      String categoryId, String token, String page) async {
    print('cat id is $categoryId');
    if (!await networkInfo.isConnected) return NetworkFailure();

    http.Response response = await client.get(
      Uri.parse(
          Endpoints.getProductsById.path(categoryId: categoryId, page: page)),
      headers: Endpoints.getProductsById.headers(),
    );
    if (response.isSuccess) {
      var json = jsonDecode(response.body);
      return json['data']['products'];
    }
  }

  Future<dynamic> getProducts(String token, String page) async {
    print('resp getProducts');
    if (!await networkInfo.isConnected) return NetworkFailure();

    http.Response response = await client.get(
      Uri.parse(Endpoints.getProducts.path(page: page)),
      headers: Endpoints.getProducts.headers(),
    );
    if (response.isSuccess) {
      var json = jsonDecode(response.body);
      print('resp is $json');
      return json['data']['products'];
    }
  }

  Future<dynamic> addToCartWithQuantity(
      String token, String productId, String quantity) async {
    if (!await networkInfo.isConnected) return NetworkFailure();

    http.Response response = await client.get(
      Uri.parse(Endpoints.addToCartORincreaseQuantity
          .path(productId: productId, quantity: quantity)),
      headers: Endpoints.addToCartORincreaseQuantity.headers(),
    );
    if (response.isSuccess) {
      var json = jsonDecode(response.body);
      print('item added');
      print('item $quantity $json');
      return json['data'];
    }
    print('Item wasnot added to cart');
  }

  Future<dynamic> getCartProducts(String token) async {
    if (!await networkInfo.isConnected) return NetworkFailure();

    http.Response response = await client.get(
      Uri.parse(Endpoints.getCartProducts.path()),
      headers: Endpoints.getCartProducts.headers(),
    );
    if (response.isSuccess) {
      var json = jsonDecode(response.body);
      print('items added to Cart');

      return json['data']['baskets'];
    }
    print('items wasnot fetched to Cart');
  }

  Future<dynamic> deleteFromCart(String token, String productId) async {
    if (!await networkInfo.isConnected) return NetworkFailure();

    http.Response response = await client.get(
      Uri.parse(Endpoints.deleteFromCart.path(productId: productId)),
      headers: Endpoints.deleteFromCart.headers(),
    );
    if (response.isSuccess) {
      var json = jsonDecode(response.body);
      print('Item was deleted from cart');

      return json['data'];
    }

    print('Item wasnot deleted from cart');
  }

  Future<dynamic> getFavorites(String token) async {
    if (!await networkInfo.isConnected) return NetworkFailure();

    http.Response response = await client.get(
      Uri.parse(Endpoints.getFavorites.path()),
      headers: Endpoints.getFavorites.headers(),
    );
    if (response.isSuccess) {
      var json = jsonDecode(response.body);
      print('Items was fetched from favorites');

      return json['data'];
    }

    print('Items was not fetched from favorites');
  }

  Future<dynamic> addToFavorites(String token, String productId) async {
    if (!await networkInfo.isConnected) return NetworkFailure();

    http.Response response = await client.get(
      Uri.parse(Endpoints.addToFavorites.path(productId: productId)),
      headers: Endpoints.addToFavorites.headers(),
    );
    if (response.isSuccess) {
      var json = jsonDecode(response.body);
      print('Item was added to favorites');

      return json['data'];
    }

    print('Item was not added to favorites');
  }

  Future<dynamic> deleteFromFavorites(String token, String productId) async {
    if (!await networkInfo.isConnected) return NetworkFailure();

    http.Response response = await client.get(
      Uri.parse(Endpoints.deleteFromCart.path(productId: productId)),
      headers: Endpoints.deleteFromCart.headers(),
    );
    if (response.isSuccess) {
      var json = jsonDecode(response.body);
      print('Item was deleted from favorites');

      return json['data'];
    }

    print('Item was not deleted from favorites');
  }



  Future<dynamic> checkout(
      {String token,
      String deliveryType,
      bool recall,
      bool contactlessDelivery,
      String address,
      String comment}) async {
    if (!await networkInfo.isConnected) return NetworkFailure();

    http.Response response = await client.get(
      Uri.parse(Endpoints.checkout.path(
        deliveryType: deliveryType,
        recall: recall,
        contactlessDelivery: contactlessDelivery,
        address: address,
        comment: comment,
      )),
      headers: Endpoints.checkout.headers(),
    );
    if (response.isSuccess) {
      var json = jsonDecode(response.body);
      print(json);

      return json['data'];
    }
    print('Item was not checked out successfully');
  }


  void dispose() {
    this.client.close();
  }
}
