import 'package:my_recipes_app/models/ingredient.dart';

class Recipe{
  String id;
  String name;
  String photoUrl;
  String description;
  int userId;
  String catId;
  List<Ingredient> ingredients = [];

  Recipe({
    required this.id,
    required this.name,
    required this.photoUrl,
    required this.description,
    required this.userId,
    required this.catId
  });

  Recipe.fromMap(Map<String, dynamic> map)
      : id = map["id"].toString(),
        name = map["name"],
        photoUrl = map["photoUrl"],
        description = map["description"],
        catId = map["catId"].toString(),
        userId = map['userId'],
        ingredients = (map["ingredients"] as List).map((item) => Ingredient.fromMap(item)).toList();

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "photoUrl": photoUrl,
      "description": description,
      "catId": catId,
      "userId": userId,
      "ingredients": ingredients.map((ingredient) => ingredient.toMap())
          .toList()
    };
  }
}