import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../common/logout.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _listScrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Recipes",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(255, 250, 221, 1),
            )),
        backgroundColor: const Color.fromRGBO(1, 29, 43, 1),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              onTap: () {
                logout(context);
              },
              title: Text("Sair"),
              leading: Icon(Icons.logout),
            )
          ],
        ),
      ),
      body: Container(
        color: Color.fromRGBO(52, 80, 94, 1),
        child: ListView(
            controller: _listScrollController,
            children: [] //TO-DO: lista de receitas aqui!,
            ),
      ),
    );
  }
  
  //TO-DO refresh function
  void refresh()async{
    SharedPreferences.getInstance().then((prefs){
      String? token = prefs.getString("accessToken");
      String? email = prefs.getString("email");
      int? id = prefs.getInt("id");

      //TO-DO: tratar erros.
    });
  }
  
}
