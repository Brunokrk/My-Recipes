import 'package:flutter/material.dart';
import 'package:my_recipes_app/screens/Home-Screen/widgets/category_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../common/logout.dart';
import '../../models/category.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _listScrollController = ScrollController();
  final CategoryService catService = CategoryService();

  Map<String, Category> database = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My Categories",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white, // Alterado para branco puro
          ),
        ),
        backgroundColor: const Color.fromRGBO(1, 29, 43, 1),
        centerTitle: true, // Adicionado para centralizar o título
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              onTap: () {
                logout(context);
              },
              title: const Text("Sair"),
              leading: const Icon(Icons.logout),
            )
          ],
        ),
      ),
      body: Container(
        color: const Color.fromRGBO(52, 80, 94, 1),
        child: ListView(
          controller: _listScrollController,
          children: [
            CategoryCard(
                urlPhoto:
                    "https://moinhoglobo.com.br/wp-content/uploads/2019/10/13-donuts-1024x681.jpg",
                name: "Categoria Teste",
                onTap: () {}),
            CategoryCard(
                urlPhoto:
                    "https://moinhoglobo.com.br/wp-content/uploads/2019/10/13-donuts-1024x681.jpg",
                name: "Categoria Teste",
                onTap: () {}), // TODO: lista de categorias aqui!
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed("addCategory");
        },
        backgroundColor: const Color(0xFFDC6425),
        child: const Icon(
          Icons.add_outlined,
          size: 31,
        ),
      ),
    );
  }

  // TO-DO refresh function
  void refresh() async {
    SharedPreferences.getInstance().then((prefs) {
      String? token = prefs.getString("accessToken");
      String? email = prefs.getString("email");
      int? id = prefs.getInt("id");

      // TO-DO: tratar erros.
    });
  }
}
