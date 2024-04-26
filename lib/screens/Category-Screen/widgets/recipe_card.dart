import 'package:flutter/material.dart';
import '../../../models/recipe.dart';

class RecipeCard extends StatelessWidget {
  final Recipe recipe;
  final Function refreshFunction;
  final int userId;
  final String token;

  const RecipeCard({
    super.key,
    required this.recipe,
    required this.refreshFunction,
    required this.userId,
    required this.token,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          onCardTap(context, recipe); // Abre a receita para visualização
        },
        child: Card(
          color: Colors.grey[200],  // Cor de fundo do card
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),  // Bordas arredondadas
          ),
          elevation: 5.0,  // Elevação para dar um efeito de sombra
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
                    recipe.photoUrl,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        recipe.name,
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        recipe.description,
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.black.withOpacity(0.6),  // Opacidade reduzida
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: IconButton(
                  icon: Icon(Icons.edit, color: Colors.grey),
                  onPressed: () {
                    //TODO: update recipe
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onCardTap(BuildContext context, Recipe recipe) {
    Map<String, dynamic> map = {};
    map['recipe'] = recipe;
    Navigator.pushNamed(context, 'recipe-screen', arguments: map);
  }
}
