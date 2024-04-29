import 'dart:io';
import 'package:flutter/material.dart';
import 'package:my_recipes_app/services/recipe_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../common/exception_dialog.dart';
import '../../common/logout.dart';
import '../../models/category.dart';
import '../../models/recipe.dart';
import '../../services/image_service.dart';

class AddRecipeScreen extends StatelessWidget {
  final Recipe? existingRecipe;
  final Category? category;
  final TextEditingController _name = TextEditingController();
  final TextEditingController _url = TextEditingController();
  final TextEditingController _ingredients = TextEditingController();
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
        title: const Text("New Recipe", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildTextFormField(_name, "Recipe Name", Icons.book),
              const SizedBox(height: 20),
              _buildImageUrlField(context, _url),
              const SizedBox(height: 20),
              _buildTextFormField(_ingredients, "Ingredients", Icons.list, isMultiline: true),
              const SizedBox(height: 20),
              _buildTextFormField(_preparation, "Method of preparation", Icons.format_align_left, isMultiline: true),
              const SizedBox(height: 40),
              _buildButton(context, "Create", registerOrUpdateRecipe),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField(TextEditingController controller, String label, IconData icon, {bool isMultiline = false}) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(color: Colors.black),
      maxLines: isMultiline ? null : 1,
      keyboardType: isMultiline ? TextInputType.multiline : TextInputType.text,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 16),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        prefixIcon: Icon(icon, color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }

  Widget _buildImageUrlField(BuildContext context, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        labelText: "Image URL",
        labelStyle: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 16),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        prefixIcon: const Icon(Icons.link, color: Colors.grey),
        suffixIcon: IconButton(
          icon: const Icon(Icons.image_search, color: Color(0xFFDC6425)),
          onPressed: () => fetchAndSetImageUrl(context),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }

  Widget _buildButton(BuildContext context, String text, Function action) {
    return ElevatedButton(
      onPressed: () => action(context),
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white, backgroundColor: const Color(0xFFDC6425),
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      child: Text(text, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
    );
  }

  void fetchAndSetImageUrl(BuildContext context) {
    if (_name.text.isEmpty) {
      showExceptionDialog(context, content: 'Please enter the recipe name to search for an image.');
      return;
    }

    // Assumindo que ImageService possui um método fetchImages que retorna uma lista de URLs de imagens
    ImageService imageService = ImageService();
    imageService.listImages(_name.text).then((imageUrls) {
      if (imageUrls.isEmpty) {
        showExceptionDialog(context, content: 'No images found for this recipe.');
        return;
      }

      showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return AlertDialog(
            title: const Text('Select an Image'),
            content: SingleChildScrollView(
              child: SizedBox(
                width: double.maxFinite,
                height: MediaQuery.of(context).size.height * 0.8,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 4.0,
                    mainAxisSpacing: 4.0,
                  ),
                  itemCount: imageUrls.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        _url.text = imageUrls[index];
                        Navigator.of(dialogContext).pop();
                      },
                      child: Image.network(imageUrls[index], fit: BoxFit.cover),
                    );
                  },
                ),
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Close'),
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                },
              ),
            ],
          );
        },
      );
    }).catchError((error) {
      showExceptionDialog(context, content: 'Failed to fetch images: ${error.toString()}');
    });
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
