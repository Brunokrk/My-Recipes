import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_recipes_app/services/category_service.dart';
import 'package:my_recipes_app/services/image_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../../common/exception_dialog.dart';
import '../../common/logout.dart';
import '../../models/category.dart';

class AddCategoryScreen extends StatelessWidget {
  final Category? existingCategory;
  final TextEditingController _name = TextEditingController();
  final TextEditingController _url = TextEditingController();

  AddCategoryScreen({
    super.key,
    this.existingCategory
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
        title: const Text(
          "New Category",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white, // Alterado para branco puro
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: TextFormField(
                          controller: _name,
                          style: const TextStyle(color:Colors.black),
                          decoration: const InputDecoration(
                            labelText: 'Nome da Categoria',
                            labelStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 25,
                            ),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            floatingLabelAlignment:
                                FloatingLabelAlignment.center,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: TextFormField(
                          controller: _url,
                          style: const TextStyle(color:Colors.black),
                          decoration: const InputDecoration(
                            labelText: 'Url da Imagem',
                            labelStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 25,
                            ),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            floatingLabelAlignment:
                                FloatingLabelAlignment.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    fetchAndSetImageUrl(context);
                  }, // Adicione sua função de envio aqui
                  child: const Text(
                    "Search For an Image",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                  child: ElevatedButton(
                    onPressed: () {
                      registerOrUpdateCategory(context);
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
    );
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

  void fetchAndSetImageUrl(BuildContext context) {
    if (_name.text.isEmpty) {
      showExceptionDialog(context, content: 'Por favor, insira o nome da categoria para buscar uma imagem.');
      return;
    }
    ImageService imageService = ImageService();
    imageService.fetchImage(_name.text).then((imageUrl) {
      _url.text = imageUrl; // Atualiza o campo do URL automaticamente
    }).catchError((error) {
      showExceptionDialog(context, content: 'Falha ao buscar imagem: ${error.toString()}');
    });
  }

}
