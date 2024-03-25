class GlobalVariables {
  static late String _accessToken;

  static set accessToken(String value) {
    _accessToken = value;
  }

  static String get accessToken => _accessToken;
}