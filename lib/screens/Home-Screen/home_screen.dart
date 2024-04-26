import 'dart:io';
import 'package:flutter/material.dart';
import 'package:my_recipes_app/screens/Home-Screen/widgets/listing_categories.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../common/exception_dialog.dart';
import '../../common/logout.dart';
import '../../models/category.dart';
import '../../services/category_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _listScrollController = ScrollController();
  final CategoryService catService = CategoryService();

  int? userId;
  String? userToken;
  int? selectedForDeletionId;

  Map<String, Category> database = {};

  @override
  void initState() {
    refresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // actions: [
        //   IconButton(
        //       onPressed: () {
        //         refresh();
        //       },
        //       icon: const Icon(Icons.refresh))
        // ],
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
      body: (userId != null && userToken != null)
          ? ListView(
              controller: _listScrollController,
              children: generateListCategories(userId: userId!, token: userToken!, refreshFunction: refresh, database: database),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, 'add-category').then((value) {
            refresh();
            if(value!=null && value == true){
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Registro Feito com Sucesso!"),
                ),
              );
            }
          });
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
    SharedPreferences.getInstance().then(
      (prefs) {
        String? token = prefs.getString("accessToken");
        String? email = prefs.getString("email");
        int? id = prefs.getInt("id");

        if (token != null && email != null && id != null) {
          setState(() {
            userId = id;
            userToken = token;
          });

          catService.getAll(userId: id.toString(), token: token).then(
            (List<Category> listCats) {
              setState(() {
                database = {};
                for (Category category in listCats) {
                  database[category.id] = category;
                }
              });
            },
          );
        } else {
          Navigator.pushReplacementNamed(context, "login");
        }
      },
    ).catchError(
      (error) {
        logout(context);
      },
      test: (error) => error is TokenNotValidException,
    ).catchError((error) {
      showExceptionDialog(context, content: error.message);
    }, test: (error) => error is HttpException);
  }
}
