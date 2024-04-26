import 'package:my_recipes_app/models/category.dart';
import 'package:my_recipes_app/services/web_client.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

import '../models/recipe.dart';

class RecipeService {
  String url = WebClient.url;
  http.Client client = WebClient().client;

  static const String resource = "recipes/";

  String getUrl() {
    return "$url$resource";
  }

  Future<bool> register(Category category, Recipe recipe, String token) async {
    String jsonRecipe = json.encode(recipe.toMap());
    http.Response response = await client.post(
      Uri.parse(getUrl()),
      headers: {'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'},
      body: jsonRecipe,
    );

    if (response.statusCode != 201) {
      if (json.decode(response.body) == "jwt expired") {
        throw TokenNotValidException();
      }
      throw HttpException(response.body);
    }
    return true;
  }

  Future<List<Recipe>> getAll({required String userId, required String token, required Category cat}) async{
    //filtra por categoria
    http.Response response = await client.get(
      Uri.parse("${url}users/$userId/recipes?catId=${cat.id}"),
      headers: {"Authorization": "Bearer $token"},
    );

    if (response.statusCode != 200) {
      if (json.decode(response.body) == "jwt expired") {
        throw TokenNotValidException();
      }
      throw HttpException(response.body);
    }

    List<Recipe> list = [];
    List<dynamic> listDynamic = json.decode(response.body);

    for (var jsonMap in listDynamic) {
      list.add(Recipe.fromMap(jsonMap));
    }
    return list;
  }

Future<bool> update(String id, Recipe recipe, String token) async{
    String jsonRec = json.encode(recipe.toMap());
    http.Response response = await client.put(
      Uri.parse("${getUrl()}$id"),
      headers: {'Content-Type': 'application/json',
        "Authorization": "Bearer $token",},
      body: jsonRec,
    );

    if(response.statusCode !=200){
      if(json.decode(response.body) == "jwt expired"){
        throw TokenNotValidException();
      }
      throw HttpException(response.body);
    }

    return true;
}


//TODO: delete
}

class TokenNotValidException implements Exception {}

