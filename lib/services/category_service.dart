import 'package:my_recipes_app/models/category.dart';
import 'package:my_recipes_app/services/recipe_service.dart';
import 'package:my_recipes_app/services/web_client.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

import '../models/recipe.dart';

class CategoryService {
  String url = WebClient.url;
  http.Client client = WebClient().client;

  static const String resource = "categories/";

  String getUrl() {
    return "$url$resource";
  }

  Future<bool> register(Category category, String token) async {
    String jsonCat = json.encode(category.toMap());
    http.Response response = await client.post(
      Uri.parse(getUrl()),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
      body: jsonCat,
    );
    if (response.statusCode != 201) {
      if (json.decode(response.body) == "jwt expired") {
        throw TokenNotValidException();
      }

      throw HttpException(response.body);
    }
    return true;
  }

  Future<bool> update(String id, Category category, String token) async {
    String jsonCat = json.encode(category.toMap());

    http.Response response = await client.put(
      Uri.parse("${getUrl()}$id"),
      headers: {'Content-Type': 'application/json',
        "Authorization": "Bearer $token",},
      body: jsonCat,
    );

    if (response.statusCode != 200) {
      if (json.decode(response.body) == "jwt expired") {
        throw TokenNotValidException();
      }
      throw HttpException(response.body);
    }
    return true;
  }

  Future<List<Category>> getAll(
      {required String userId, required String token}) async {
    //pega tudo por usuário.
    //id do usuário (userId)
    http.Response response = await client.get(
      Uri.parse("${url}users/$userId/categories"),
      headers: {"Authorization": "Bearer $token"},
    );

    if (response.statusCode != 200) {
      if (json.decode(response.body) == "jwt expired") {
        throw TokenNotValidException();
      }
      throw HttpException(response.body);
    }

    List<Category> list = [];
    List<dynamic> listDynamic = json.decode(response.body);

    for (var jsonMap in listDynamic) {
      list.add(Category.fromMap(jsonMap));
    }
    return list;
  }

  Future<bool> delete(String userId, Category category, String token) async {
    //Primeiro buscar todas as receitas daquela categoria.
    print("Aqui");
    RecipeService recService = RecipeService();
    recService.getAll(userId: userId, token: token, cat: category).then((
        recipes) {
      print(recipes);
      for (Recipe recipe in recipes) {
        //exclui todas as receitas da categoria
        recService.delete(recipe.id, recipe, token);
      }
    });

    String catId = category.id;
    http.Response response = await client.delete(
        Uri.parse("${getUrl()}$catId"),headers:{"Authorization": "Bearer $token"});
    if (response.statusCode != 200) {
      if(json.decode(response.body) == "jwt expired"){
        throw TokenNotValidException();
      }
      throw HttpException(response.body);
    }
    return true;
  }
}
class TokenNotValidException implements Exception {}
