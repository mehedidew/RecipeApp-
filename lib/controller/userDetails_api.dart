import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:recipeapp/model/userDetailsData.dart';

import 'links.dart';

class UserDetails {
  String token;
  UserDetails(this.token);
  static String uName, uEmail;

  Future fetchData() async {
    try {
      print('here');
      final data = await http.get(Links.userDetailsApi, headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token"
      });
      final jsonData = json.decode(data.body);

      if (data.statusCode == 200) {
        uName = jsonData['result']['name'];
        uEmail = jsonData['result']['email'];

        return jsonData;
      } else {
        throw Exception('Error');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
