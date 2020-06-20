import 'dart:convert';

import 'package:http/http.dart' as http;

import 'links.dart';

class AllRecipesApi {
  String token;
  bool status = false;
  String response;
  List allRecipe = [];

  AllRecipesApi(this.token);

  Future fetchData() async {
    try {
      final data = await http.get(Links.allRecipesApi, headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token"
      });
      final jsonData = jsonDecode(data.body);
      if (data.statusCode == 200) {
        status = true;
        allRecipe.clear();
        for (var u in jsonData['data']) {
          Map recipe = {
            'title': u['title'],
            'recipeImage': u['image_url'],
            'sourceName': u['source']['name']
          };
          allRecipe.add(recipe);
        }
        return allRecipe;
      } else {
        throw Exception('Error');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
