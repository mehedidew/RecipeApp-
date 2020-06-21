import 'dart:convert';

import 'package:http/http.dart' as http;

class RecipeDetailsApi {
  String token, id;
  String response;
  bool status = false;
  List ingredientList = [];
  List directionList = [];
  RecipeDetailsApi(this.token, this.id);

  Future fetchData() async {
    try {
      final data = await http.get(
          Uri.encodeFull('https://rcapp.utech.dev/api/recipes/$id'),
          headers: {
            "Accept": "application/json",
            "Authorization": "Bearer $token",
            'id': id
          });
      final jsonData = jsonDecode(data.body);
      if (data.statusCode == 200) {
        status = true;
        var data = jsonData['data'];
        Map recipeDetails = {
          'id': data['id'],
          'title': data['title'].toString(),
          'servings': data['servings'].toString(),
          'totalTime': data['total_time'].toString(),
          'prepTime': data['prep_time'].toString(),
          'cookTime': data['cook_time'].toString(),
          'recipeImage': data['image_url'].toString(),
          'ingredients': ingredients(data['ingredients']),
          'directions': directions(data['directions']),
        };

        print(recipeDetails);
        return recipeDetails;
      } else {
        throw Exception('Error');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  ingredients(List i) {
    ingredientList.clear();
    for (var u in i) {
      Map ingredients = {
        'name': u['name'],
        'preparation': u['preparation'],
        'quantity': u['display_quantity'],
        'unit': u['unit']['abbreviation'],
      };
      ingredientList.add(ingredients);
    }
    return ingredientList;
  }

  directions(List i) {
    directionList.clear();
    for (var u in i) {
      Map directions = {
        'step': u['step'],
        'directiontext': u['text'],
      };
      directionList.add(directions);
    }
    return directionList;
  }
}
