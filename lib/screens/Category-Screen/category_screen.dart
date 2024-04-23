import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../common/logout.dart';
import '../../models/category.dart';
import '../../models/recipe.dart';
import '../../services/recipe_service.dart';

class CategoryScreen extends StatefulWidget {
  final Category innerCategory;

  const CategoryScreen({super.key, required this.innerCategory});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final ScrollController _listScrollController = ScrollController();
  final RecipeService recService = RecipeService();
  int? userId;
  String? userToken;
  Map<String, Recipe> database = {};


  @override
  void initState() {
    //refresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.innerCategory.name,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                //TODO: refresh();
              },
              icon: const Icon(Icons.refresh))
        ],
      ),
      body: Container(
        color: Colors.blue,
        height: 200,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color(0xFFDC6425),
        child: const Icon(
          Icons.add_outlined,
          size: 31,
        ),
      ),
    );
  }

  // void refresh() async {
  //   SharedPreferences.getInstance().then(
  //     (prefs) {
  //       String? token = prefs.getString("accessToken");
  //       String? email = prefs.getString("email");
  //       int? id = prefs.getInt("id");
  //
  //       if (token != null && email != null && id != null) {
  //         setState(() {
  //           userId = id;
  //           userToken = token;
  //         });
  //
  //         recService
  //             .getAll(userId: id.toString(), token: token, widget.innerCategory)
  //             .then(
  //               (List<Recipe> listRecipes) {
  //                 setState(() {
  //                   database = {};
  //                   for(Recipe recipe in listRecipes) {
  //                     database[recipe.id] = recipe;
  //                   }
  //                 });
  //               },
  //             );
  //       }else{
  //         Navigator.pushReplacementNamed(context, "login");
  //       }
  //     },
  //   ).catchError(
  //         (error) {
  //       logout(context);
  //     },
  //     test: (error) => error is TokenNotValidException,
  //   ).catchError((error) {
  //     showExceptionDialog(context, content: error.message);
  //   }, test: (error) => error is HttpException);;
  // }



}
