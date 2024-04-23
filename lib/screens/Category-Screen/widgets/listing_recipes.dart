import 'package:my_recipes_app/screens/Category-Screen/widgets/recipe_card.dart';
import '../../../models/recipe.dart';

List<RecipeCard> generateListRecipes({
  required Map<String, Recipe> database,
  required Function refreshFunction,
  required int userId,
  required String token,
}) {
  List<RecipeCard> list = [];
  database.forEach((id, recipe) {
    list.add(RecipeCard(recipe: recipe, refreshFunction: refreshFunction, userId: userId, token: token));
  });
  return list;
}
