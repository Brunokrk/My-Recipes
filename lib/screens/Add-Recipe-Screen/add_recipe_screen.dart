import 'package:flutter/material.dart';

import '../../models/recipe.dart';

class AddRecipeScreen extends StatelessWidget {
  final Recipe? existingRecipe;
  final TextEditingController _name = TextEditingController();
  final TextEditingController _url = TextEditingController();

  AddRecipeScreen({super.key, this.existingRecipe}) {
    if (existingRecipe != null) {
      _name.text = existingRecipe!.name;
      _url.text = existingRecipe!.photoUrl;
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
      body: Form(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  TextFormField(
                    controller: _name,
                    style: const TextStyle(color: Colors.black),
                    decoration: const InputDecoration(
                      labelText: 'Nome da Categoria',
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 25,
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      floatingLabelAlignment: FloatingLabelAlignment.center,
                    ),
                  ),
                  TextFormField(
                    controller: _url,
                    style: const TextStyle(color:Colors.black),
                    decoration: const InputDecoration(
                      labelText: 'Url da imagem',
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
                  TextFormField(
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
                  TextFormField(
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
                  TextFormField(
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
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
