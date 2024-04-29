import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_recipes_app/services/category_service.dart';
import 'package:my_recipes_app/services/image_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../common/exception_dialog.dart';
import '../../common/logout.dart';
import '../../models/category.dart';

class AddCategoryScreen extends StatelessWidget {
  final Category? existingCategory;
  final TextEditingController _name = TextEditingController();
  final TextEditingController _url = TextEditingController();

  AddCategoryScreen({
    super.key,
    this.existingCategory,
  }) {
    if (existingCategory != null) {
      _name.text = existingCategory!.name;
      _url.text = existingCategory!.urlPhoto;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Category", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildTextFormField(_name, "Category name", Icons.fastfood),
              const SizedBox(height: 20),
              _buildImageUrlField(context, _url),
              const SizedBox(height: 60),
              _buildButton(context, "Create", registerOrUpdateCategory),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField(TextEditingController controller, String label, IconData icon) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(color: Colors.black),
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
      showExceptionDialog(context, content: 'Por favor, insira o nome da categoria para buscar uma imagem.');
      return;
    }
    ImageService imageService = ImageService();
    imageService.listImages(_name.text).then((imageUrls) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Select an Image'),
            content: SingleChildScrollView(
              child: Container(
                width: double.maxFinite,
                height: MediaQuery.of(context).size.height * 0.8, // Ajusta a altura do container para 80% da altura da tela
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, // Número de colunas
                    crossAxisSpacing: 4.0, // Espaçamento horizontal
                    mainAxisSpacing: 4.0,  // Espaçamento vertical
                  ),
                  itemCount: imageUrls.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        _url.text = imageUrls[index];
                        Navigator.of(context).pop();
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
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }).catchError((error) {
      showExceptionDialog(context, content: 'Falha ao buscar imagem: ${error.toString()}');
    });
  }

  registerOrUpdateCategory(BuildContext context) {
    SharedPreferences.getInstance().then(
          (prefs) {
        String? token = prefs.getString("accessToken");
        if (token != null) {
          int userId = prefs.getInt("id")!;
          Category category =
              existingCategory ?? Category.empty(userIdd: userId);
          category.name = _name.text;
          category.urlPhoto = _url.text;

          CategoryService service = CategoryService();
          if (existingCategory == null) {
            service.register(category, token).then((response) {
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
            service.update(category.id,category, token).then((response){Navigator.pop(context, response);},);
          }
        }
      },
    );
  }
}
