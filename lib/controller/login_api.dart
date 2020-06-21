import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:recipeapp/controller/links.dart';
import 'package:recipeapp/model/tokenManager.dart';

class LoginApi {
  final String email;
  final String password;
  LoginApi(this.email, this.password);
  static bool status = false;
  String response;

  Future fetchData() async {
    try {
      final data = await http.post(Links.loginApi,
          headers: {"Accept": "application/json"},
          body: {'email': email, 'password': password});
      final jsonData = json.decode(data.body);

      if (data.statusCode == 200) {
        status = true;
        response = jsonData['response'];
        TokenManager.fromJson(jsonData['result']);

        return jsonData['result']['token'];
      } else {
        throw Exception('Error');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
