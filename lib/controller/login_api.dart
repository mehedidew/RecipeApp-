import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:recipeapp/controller/links.dart';
import 'package:recipeapp/model/token.dart';

class LoginApi {
  final String email;
  final String password;
  LoginApi(this.email, this.password);
  static String response;

  Future fetchData() async {
    try {
      final data = await http.post(Links.loginApi,
          headers: {"Accept": "application/json"},
          body: {'email': email, 'password': password});
      final jsonData = json.decode(data.body);

      if (data.statusCode == 200) {
        response = jsonData['response'];
        Token.fromJson(jsonData['result']);

        return jsonData;
      } else {
        throw Exception('Error');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
