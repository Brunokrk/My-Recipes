import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_recipes_app/services/category_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../../common/exception_dialog.dart';
import '../../common/logout.dart';
import '../../models/category.dart';

class AddCategoryScreen extends StatelessWidget {
  AddCategoryScreen({super.key});

  final TextEditingController _name = TextEditingController();
  final TextEditingController _url = TextEditingController();


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
                          decoration: InputDecoration(
                            labelText: 'Nome da Categoria',
                            labelStyle: const TextStyle(
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
                          decoration: InputDecoration(
                            labelText: 'Url da Imagem',
                            labelStyle: const TextStyle(
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
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                  child: ElevatedButton(
                    onPressed: () {
                      registerCategory(context);
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

  registerCategory(BuildContext context) {
    SharedPreferences.getInstance().then(
      (prefs) {
        String? token = prefs.getString("accessToken");
        if (token != null) {
          Category category = Category.empty(userIdd: prefs.getInt("id")!);
          category.name = _name.text;
          category.urlPhoto = _url.text;

          CategoryService service = CategoryService();
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
        }
      },
    );
  }
}
