import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/category.dart';

class AddCategoryScreen extends StatelessWidget {
  AddCategoryScreen({super.key});

  final TextEditingController _name = TextEditingController();
  final TextEditingController _url = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text(
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
          //key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextFormField(
                controller: _name,

                decoration: const InputDecoration(
                  labelText: 'Nome da Categoria',
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Cor do texto em branco
                  ),
                ),
              ),
              TextFormField(
                controller: _url,
                decoration: const InputDecoration(
                  labelText: 'Url da imagem',
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Cor do texto em branco
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                child: ElevatedButton(
                  onPressed:(){},// _submitForm,
                  child: const Text(
                    "Create",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // Alterado para branco puro
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  registerCategory(BuildContext context){
    SharedPreferences.getInstance().then((prefs) {
      String? token = prefs.getString("accessToken");
      if(token != null){
        String name = _name.text;
        String url = _url.text;

      }
    });

  }

}
