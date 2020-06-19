import 'package:shared_preferences/shared_preferences.dart';

class TokenManager {
  String _token;

  saveToken(String token) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('TOKEN', token);
    _token = token;
  }

  TokenManager.fromJson(Map json) {
    if (json.containsKey('token')) {
      setToken(json['token']);
    }
  }

  String get token => _token; // To ensure readonly

  Future<Null> setToken(String token) async {
    // set your _token here
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('TOKEN', token);
    _token = token;
  }
}
