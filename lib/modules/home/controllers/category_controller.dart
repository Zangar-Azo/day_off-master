import 'package:flutter/material.dart';
import 'package:new_app/api/repository.dart';
import 'package:new_app/modules/home/models/category_model.dart';
import 'package:new_app/modules/home/models/product_model.dart';

enum CategoryState { Initial, Loading, Error, Loaded }

class CategoryController with ChangeNotifier {
  CategoryState _state = CategoryState.Initial;
  List<CategoryModel> categories = [];
  List<ProductModel> products = [];

  GlobalRepository api;

  CategoryController({this.api}) {
    String token = '';
    getCategories(token);
  }

  CategoryState get state => _state;

  void setState(CategoryState viewState) {
    _state = viewState;
    notifyListeners();
  }

  Future<bool> getCategories(String token) async {
    print("category controller -> get Categories -> data: ");
    setState(CategoryState.Loading);
    var data = await api.getCategories(token) as List;
    if (data != null) {
      categories = data.map((el) => CategoryModel.fromJson(el)).toList();

      setState(CategoryState.Loaded);
      return true;
    }

    setState(CategoryState.Error);
    return false;
  }

  Future<bool> getProductsById(
      {String token, String categoryId, String page}) async {
    print("category controller -> get ProductsById -> data: ");

    setState(CategoryState.Loading);
    var data = await api.getProductsById(categoryId, token, page) as List;
    if (data != null) {
      products = data.map((el) => ProductModel.fromJson(el)).toList();

      setState(CategoryState.Loaded);
      return true;
    }

    setState(CategoryState.Error);
    return false;
  }

  Future<bool> getNextProductsById(
      {String token, String categoryId, String page}) async {
    var data = await api.getProductsById(categoryId, token, page) as List;
    if (data != null) {
      List list = data.map((el) => ProductModel.fromJson(el)).toList();
      products.addAll([...list]);

      return true;
    }

    setState(CategoryState.Error);
    return false;
  }

  Future<bool> getProducts({String token, String page}) async {
    print("category controller -> get Products -> data: ");
    setState(CategoryState.Loading);
    var data = await api.getProducts(token, page) as List;
    if (data != null) {
      products = data.map((el) => ProductModel.fromJson(el)).toList();

      setState(CategoryState.Loaded);
      return true;
    }

    setState(CategoryState.Error);
    return false;
  }
}
