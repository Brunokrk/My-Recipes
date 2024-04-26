import 'package:my_recipes_app/models/ingredient.dart';
import 'package:uuid/uuid.dart';

class Recipe{
  String id;
  String name;
  String photoUrl;
  String description;
  int userId;
  String catId;
  String ingredients;

  Recipe({
    required this.id,
    required this.name,
    required this.photoUrl,
    required this.description,
    required this.ingredients,
    required this.userId,
    required this.catId
  });

  Recipe.empty({required int userIdd, required String catIdd})
    :id = const Uuid().v1(),
      name = "",
      photoUrl = "",
      description = "",
      ingredients = "",
      userId = userIdd,
      catId = catIdd;

  Recipe.fromMap(Map<String, dynamic> map)
      : id = map["id"].toString(),
        name = map["name"],
        photoUrl = map["photoUrl"],
        description = map["description"],
        catId = map["catId"].toString(),
        userId = map['userId'],
        ingredients = map["ingredients"];

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "photoUrl": photoUrl,
      "description": description,
      "catId": catId,
      "userId": userId,
      "ingredients": ingredients
    };
  }
}