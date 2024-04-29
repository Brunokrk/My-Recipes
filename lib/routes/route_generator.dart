import 'package:flutter/material.dart';

import 'package:my_recipes_app/models/category.dart';
import 'package:my_recipes_app/models/recipe.dart';

import '../screens/Add-Category-Screen/add_category_screen.dart';
import '../screens/Add-Recipe-Screen/add_recipe_screen.dart';
import '../screens/Category-Screen/category_screen.dart';
import '../screens/Home-Screen/home_screen.dart';
import '../screens/Login-Screen/login_screen.dart';
import '../screens/Recipe-Screen/recipe_screen.dart';

class RouteGenerator {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case 'home':
        return MaterialPageRoute(builder: (context) => const HomeScreen());
      case 'login':
        return MaterialPageRoute(builder: (context) => LoginScreen());
      case 'add-category':
        if (settings.arguments != null) {
          final Map<String, dynamic> args = settings.arguments as Map<String, dynamic>;
          if (args.containsKey('category')) {
            final Category category = args['category'] as Category;
            return MaterialPageRoute(builder: (context) => AddCategoryScreen(existingCategory: category));
          }
        }
        return MaterialPageRoute(builder: (context) => AddCategoryScreen());
      case 'category-screen':
        if (settings.arguments != null) {
          final Map<String, dynamic> args = settings.arguments as Map<String, dynamic>;
          final Category category = args['category'] as Category;
          return MaterialPageRoute(builder: (context) => CategoryScreen(innerCategory: category));
        }
        break;
      case 'add-recipe':
        if (settings.arguments != null) {
          final Map<String, dynamic> args = settings.arguments as Map<String, dynamic>;
          if (args.containsKey('recipe')) {
            final Recipe recipe = args['recipe'] as Recipe;
            return MaterialPageRoute(builder: (context) => AddRecipeScreen(existingRecipe: recipe));
          } else if (args.containsKey('category')) {
            final Category category = args['category'] as Category;
            return MaterialPageRoute(builder: (context) => AddRecipeScreen(category: category));
          }
        }
        return MaterialPageRoute(builder: (context) => AddRecipeScreen());
      case 'recipe-screen':
        if (settings.arguments != null) {
          final Map<String, dynamic> args = settings.arguments as Map<String, dynamic>;
          final Recipe recipe = args['recipe'] as Recipe;
          return MaterialPageRoute(builder: (context) => RecipeScreen(recipe: recipe));
        }
        break;
      default:
        return MaterialPageRoute(builder: (context) => const HomeScreen());  // Fallback for undefined routes
    }
    return null;  // fail
  }
}
