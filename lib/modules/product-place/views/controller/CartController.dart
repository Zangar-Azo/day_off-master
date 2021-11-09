import 'package:flutter/material.dart';
import 'package:new_app/api/repository.dart';
import 'package:new_app/modules/home/models/product_model.dart';

enum CartState { Initial, Loading, Error, Loaded }

class CartController with ChangeNotifier {
  CartState _state = CartState.Initial;
  List<ProductModel> cartProducts = [];
  List<ProductModel> orderProducts = [];

  GlobalRepository api;

  CartController({this.api}) {
    String token = '';
    getCategories(token);
  }

  CartState get state => _state;

  void setState(CartState viewState) {
    _state = viewState;
    notifyListeners();
  }

  Future<bool> getCategories(String token) async {
    print("category controller -> get Categories -> data: ");
    setState(CartState.Loading);
    var data = await api.getCategories(token) as List;
    if (data != null) {
      setState(CartState.Loaded);
      return true;
    }

    setState(CartState.Error);
    return false;
  }

  Future<bool> decreaseCartQuantity(ProductModel product, String token) async {
    bool _success = false;
    if (!num.parse(product.quantity).isNegative) {
      ProductModel foundProduct = cartProducts.firstWhere(
        (element) => element.id == product.id,
      );

      if (foundProduct != null) {
        product.decreaseQuantity();
        var data = await api.addToCartWithQuantity(
            token, product.id, product.quantity);
        var _result = data['added'];
        if (_result) {
          cartProducts.removeWhere((element) => element.id == product.id);
          cartProducts.add(product);
          _success = true;
        }
      } else {
        product.quantity = '0';
        product.changeBoughtState();
        cartProducts.removeWhere((element) => element.id == product.id);
      }

      notifyListeners();
    }

    return _success;
  }

  Future<bool> incrementCardCount(ProductModel product, String token) async {
    bool _success = false;
    ProductModel foundProduct;
    try {
      foundProduct = cartProducts.firstWhere(
        (element) => element.id == product.id,
      );
    } catch (e) {}

    product.increaseQuantity();
    if (foundProduct != null) {
      cartProducts.removeWhere((element) => element.id == product.id);
    }
    var data =
        await api.addToCartWithQuantity(token, product.id, product.quantity);

    var result = data['added'];
    if (result) {
      print('data added ${product.quantity}');
      cartProducts.add(product);
      _success = true;
    }
    notifyListeners();

    return _success;
  }

  Future<bool> addToCart(ProductModel product, String token) async {
    setState(CartState.Loading);
    var data =
        await api.addToCartWithQuantity(token, product.id, product.quantity);
    var success = data['added'];
    if (success) {
      product.changeBoughtState();
      setState(CartState.Loaded);
      return true;
    }

    setState(CartState.Error);
    return false;
  }

  Future<bool> getCartProducts(String token) async {
    setState(CartState.Loading);
    print('getCartProducts in controller');
    var data = await api.getCartProducts(token);

    if (data != null && data is List) {
      cartProducts = data.map((el) => ProductModel.fromJson(el)).toList();
      print(cartProducts);
      setState(CartState.Loaded);
      return true;
    }

    setState(CartState.Error);
    return false;
  }

  Future<bool> deleteFromCart(ProductModel product, String token) async {
    print("Deleting from cart");
    setState(CartState.Loading);
    var data = await api.deleteFromCart(token, product.id);
    var success = data['deleted'];

    if (success) {
      product.changeBoughtState();
      cartProducts.remove(product);

      setState(CartState.Loaded);
      return true;
    }

    setState(CartState.Error);
    return false;
  }

  Future<bool> addToFavorites(ProductModel product, String token) async {
    print("add to favorites");
    var data = await api.addToFavorites(token, product.id);
    var success = data['added'];

    if (success) {
      setState(CartState.Loaded);
      return true;
    }

    setState(CartState.Error);
    return false;
  }

  Future<bool> deleteFromFavorites(ProductModel product, String token) async {
    print("delete from favorites");
    var data = await api.deleteFromCart(token, product.id);
    var success = data['deleted'];

    if (success) {
      setState(CartState.Loaded);
      return true;
    }

    setState(CartState.Error);
    return false;
  }

  Future<bool> checkoutProducts({
    String token,
    String deliveryType,
    String address,
    String comment,
    bool recall,
    bool contactlessDelivery,
  }) async {
    setState(CartState.Loading);

    var data = await api.checkout(
      deliveryType: deliveryType,
      address: address,
      comment: comment,
      recall: recall,
      contactlessDelivery: contactlessDelivery,
    );
    var success = data['order_created'];
    setState(CartState.Loaded);
    return success;
  }
}
