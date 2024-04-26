import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_recipes_app/services/recipe_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../common/exception_dialog.dart';
import '../../common/logout.dart';
import '../../models/category.dart';
import '../../models/recipe.dart';

class AddRecipeScreen extends StatelessWidget {
  final Recipe? existingRecipe;
  final Category? category;
  final TextEditingController _name = TextEditingController();
  final TextEditingController _url = TextEditingController();
  final TextEditingController _ingredients =
      TextEditingController(); // Controlador para ingredientes
  final TextEditingController _preparation = TextEditingController();

  AddRecipeScreen({super.key, this.existingRecipe, this.category}) {
    if (existingRecipe != null) {
      _name.text = existingRecipe!.name;
      _url.text = existingRecipe!.photoUrl;
      _ingredients.text = existingRecipe!.ingredients;
      _preparation.text = existingRecipe!.description;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "New Recipe",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white, // Alterado para branco puro
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: TextFormField(
                            controller: _name,
                            style: const TextStyle(color: Colors.black),
                            decoration: const InputDecoration(
                              labelText: 'Receita',
                              labelStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 25,
                              ),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              floatingLabelAlignment:
                                  FloatingLabelAlignment.center,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: TextFormField(
                            controller: _url,
                            style: const TextStyle(color: Colors.black),
                            decoration: const InputDecoration(
                              labelText: 'Url da imagem',
                              labelStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 25,
                              ),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              floatingLabelAlignment:
                                  FloatingLabelAlignment.center,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: TextFormField(
                            controller: _ingredients,
                            style: const TextStyle(color: Colors.black),
                            decoration: const InputDecoration(
                              labelText: 'Ingredientes',
                              labelStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 25,
                              ),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              floatingLabelAlignment:
                                  FloatingLabelAlignment.center,
                            ),
                            keyboardType: TextInputType.multiline,
                            maxLines: null, // Permite múltiplas linhas
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: TextFormField(
                            controller: _preparation,
                            style: const TextStyle(color: Colors.black),
                            decoration: const InputDecoration(
                              labelText: 'Modo de Preparo',
                              labelStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 25,
                              ),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              floatingLabelAlignment:
                                  FloatingLabelAlignment.center,
                            ),
                            keyboardType: TextInputType.multiline,
                            maxLines: null, // Permite múltiplas linhas
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                    child: ElevatedButton(
                      onPressed: () {
                        registerOrUpdateRecipe(context);
                      }, // Adicione sua função de envio aqui
                      child: const Text(
                        "Create",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  registerOrUpdateRecipe(BuildContext context) {
    SharedPreferences.getInstance().then((prefs) {
      String? token = prefs.getString("accessToken");
      if (token != null) {
        int? userId = prefs.getInt("id");
        Recipe recipe = existingRecipe ??
            Recipe.empty(userIdd: userId!, catIdd: category!.id);
        recipe.name = _name.text;
        recipe.description = _preparation.text;
        recipe.photoUrl = _url.text;
        recipe.ingredients = _ingredients.text;

        RecipeService service = RecipeService();
        if (existingRecipe == null) {
          service.register(category!, recipe, token).then((response) {
            Navigator.pop(context, response);
          }).catchError(
                (error) {
              logout(context);
            },
            test: (error) => error is TokenNotValidException,
          ).catchError((error) {
            showExceptionDialog(context, content: error.message);
          }, test: (error) => error is HttpException);
        }else{
          service.update(recipe.id, recipe, token).then((response){Navigator.pop(context, response);},);
        }
      }
    });
  }
}
