import 'package:shared_preferences/shared_preferences.dart';

class Token {
  saveToken(String token) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('TOKEN', token);
  }

  Token.fromJson(Map json) {
    if (json.containsKey('token')) {
      saveToken(json['token']);
    }
  }
}
