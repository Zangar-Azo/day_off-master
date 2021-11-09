import 'package:flutter/material.dart';
import 'package:new_app/core/config/auth_config.dart';
import 'package:new_app/api/repository.dart';
import 'package:new_app/core/provider/auth/models/user_model.dart';

enum ViewState { Initial, Loading, Error, Loaded, UserLoaded }

class AuthController with ChangeNotifier {
  ViewState _state = ViewState.Initial;
  AuthConfig authConfig;
  GlobalRepository api;

  AuthController({this.api, this.authConfig}) {
    getUserLocally();
  }

  Future<UserModel> getUserLocally() async {
    setState(ViewState.Loading);
    var user = await api.getUserLocally('');
    setState(ViewState.UserLoaded);
    return user;
  }

  ViewState get state => _state;

  void setState(ViewState viewState) {
    _state = viewState;
    notifyListeners();
  }

  Future<bool> sendCode(String phone) async {
    setState(ViewState.Loading);

    var success = await api.createCode(phone);

    if (success != null) {
      setState(ViewState.Loaded);

      return true;
    }

    setState(ViewState.Error);
    return false;
  }

  Future<bool> login(String phone, String code) async {
    setState(ViewState.Loading);

    var success = await api.login(phone, code);

    if (success != null) {
      setState(ViewState.Loaded);

      return true;
    }

    setState(ViewState.Error);
    return false;
  }
}
