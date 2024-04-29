import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_recipes_app/common/remove_confirmation_dialog.dart';
import 'package:my_recipes_app/services/category_service.dart';
import '../../../common/exception_dialog.dart';
import '../../../common/logout.dart';
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onLongPress: () {
          removeCategory(context);
        },
        onTap: () {
          onCardTap(context, category);
        },
        child: Card(
          color: Colors.grey[200],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          elevation: 5.0,
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    bottomLeft: Radius.circular(20.0),
                  ),
                  child: Image.network(
                    category.urlPhoto,
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
                        category.name,
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Colors
                              .black,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: IconButton(
                  icon: const Icon(Icons.edit, color: Colors.grey),
                  onPressed: () {
                    Map<String, dynamic> map = {};
                    map["category"] = category;
                    Navigator.pushNamed(context, 'add-category', arguments: map)
                        .then((value) {
                      refreshFunction();
                      if (value != null && value == true) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Alteração Feita com Sucesso!"),
                          ),
                        );
                      }
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  onCardTap(BuildContext context, Category category) {
    Map<String, dynamic> map = {};
    map['category'] = category;
    Navigator.pushNamed(context, 'category-screen', arguments: map);
  }

  removeCategory(BuildContext context) {
    CategoryService service = CategoryService();
    showConfirmationDialog(context,
            content:
                "Do you really want to delete the category ${category.name}? This will also delete all recipes linked to the category",
            affirmativeOption: "Delete",
            textStyle: const TextStyle(color: Colors.black))
        .then((value) {
      if (value != null) {
        if (value) {
          service.delete(userId.toString(), category, token).then((value) {
            if (value) {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Item deleted successfully")));
              refreshFunction();
            }
          });
        }
      }
    }).catchError(
      (error) {
        logout(context);
      },
      test: (error) => error is TokenNotValidException,
    ).catchError((error) {
      showExceptionDialog(context, content: error.message);
    }, test: (error) => error is HttpException);
    }
}
