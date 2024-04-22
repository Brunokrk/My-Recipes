import 'package:flutter/material.dart';
import '../../../models/category.dart';

class CategoryCard extends StatelessWidget {
  final Category category;
  final Function refreshFunction;
  final int userId;
  final String token;

  const CategoryCard({
    Key? key,
    required this.category,
    required this.refreshFunction,
    required this.userId,
    required this.token,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Card(
        color: Colors.white, // Definindo a cor de fundo do card como branco
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  bottomLeft: Radius.circular(20.0),
                ),
                child: Image.network(
                  category!.urlPhoto,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      category!.name,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color:
                            Colors.black, // Definindo a cor do texto como preto
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  //TODO: Remove Category

}
