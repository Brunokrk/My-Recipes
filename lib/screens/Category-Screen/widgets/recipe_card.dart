import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_recipes_app/common/remove_confirmation_dialog.dart';
import 'package:my_recipes_app/services/recipe_service.dart';
import '../../../common/exception_dialog.dart';
import '../../../common/logout.dart';
import '../../../models/recipe.dart';

class RecipeCard extends StatelessWidget {
  final Recipe recipe;
  final Function refreshFunction;
  final int userId;
  final String token;

  const RecipeCard({
    super.key,
    required this.recipe,
    required this.refreshFunction,
    required this.userId,
    required this.token,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onLongPress: () {removeRecipe(context);},
        onTap: () {
          onCardTap(context, recipe);
        },
        child: Card(
          color: Colors.grey[200],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          elevation: 5.0, 
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    bottomLeft: Radius.circular(20.0),
                  ),
                  child: Image.network(
                    recipe.photoUrl,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        recipe.name,
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        recipe.description,
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.black
                              .withOpacity(0.6), // Opacidade reduzida
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: IconButton(
                  icon: Icon(Icons.edit, color: Colors.grey),
                  onPressed: () {
                    Map<String, dynamic> map = {};
                    map["recipe"] = recipe;
                    Navigator.pushNamed(context, 'add-recipe', arguments: map)
                        .then((value) {
                      refreshFunction();
                      if (value != null && value == true) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Alteração feita com Sucesso!")));
                      }
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onCardTap(BuildContext context, Recipe recipe) {
    Map<String, dynamic> map = {};
    map['recipe'] = recipe;
    Navigator.pushNamed(context, 'recipe-screen', arguments: map);
  }

  removeRecipe(context) {
    RecipeService service = RecipeService();
    if (recipe != null) {
      showConfirmationDialog(
        context,
        content: "Do you really want to delete the recipe:  ${recipe.name}?",
        affirmativeOption: "Delete",
        textStyle: TextStyle(color: Colors.black),
      ).then((value) {
        if (value != null) {
          if (value) {
            service.delete(recipe.id, recipe, token).then((value) {
              if (value) {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Item deletado com sucesso")));
                refreshFunction();
              }
            });
          }
        }
      }).catchError(
        (error) {
          logout(context);
        },
        test: (error) => error is TokenNotValidException,
      ).catchError((error) {
        showExceptionDialog(context, content: error.message);
      }, test: (error) => error is HttpException);
    }
  }
}


