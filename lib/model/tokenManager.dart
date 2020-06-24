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
      saveToken(json['token']);
    }
  }

  Future getToken() async {
    return _token;
  }
}
