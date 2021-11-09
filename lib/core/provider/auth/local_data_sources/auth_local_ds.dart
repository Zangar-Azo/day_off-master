abstract class AuthLocalDataSource {
  Future<String> getUserLocally(String token);
}

class AuthLocalDataSourceImpl extends AuthLocalDataSource {
  @override
  Future<String> getUserLocally(String token) async {
    if (token == '' || token == null) {
      return Future.delayed(Duration(seconds: 2), () => '');
    }
    return Future.delayed(Duration(seconds: 2), () => '');
  }
}
