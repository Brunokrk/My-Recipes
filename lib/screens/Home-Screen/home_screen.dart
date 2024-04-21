import 'package:flutter/material.dart';

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
                color: Color.fromRGBO(255, 250, 221, 1))),
        backgroundColor: const Color.fromRGBO(1, 29, 43, 1),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              onTap: () {},
              title: Text("Sair"),
              leading: Icon(Icons.logout),
            )
          ],
        ),
      ),
      body: ListView(
        controller: _listScrollController,
        children: []//TO-DO: lista de receitas aqui!,
      ),
    );
  }
}
