import 'package:flutter/material.dart';
import '../../models/category.dart';

class CategoryScreen extends StatelessWidget {
  final Category innerCategory;

  const CategoryScreen({super.key, required this.innerCategory});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          innerCategory.name,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        actions: [IconButton(
            onPressed: () {
              //TODO: refresh();
            },
            icon: const Icon(Icons.refresh))],
      ),
      body: Container(
        color: Colors.blue,
        height: 200,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          
        },
        backgroundColor: const Color(0xFFDC6425),
        child: const Icon(
          Icons.add_outlined,
          size: 31,
        ),
      ),
    );
  }
}
