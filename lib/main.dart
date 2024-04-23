import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_recipes_app/screens/Add-Category-Screen/add_category_screen.dart';
import 'package:my_recipes_app/screens/Category-Screen/category_screen.dart';
import 'package:my_recipes_app/screens/Home-Screen/home_screen.dart';
import 'package:my_recipes_app/screens/Login-Screen/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/category.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool isLogged = await verifyToken();
  runApp(MyApp(isLogged: isLogged));
}

Future<bool> verifyToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString("accessToken");
  if (token != null) {
    return true;
  } else {
    return false;
  }
}

class MyApp extends StatelessWidget {
  final bool isLogged;

  const MyApp({super.key, required this.isLogged});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Recipes App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color.fromRGBO(1, 29, 43, 1),
        // Cor principal da AppBar e outros elementos
        scaffoldBackgroundColor: const Color.fromRGBO(52, 80, 94, 1),
        // Cor de fundo padrão dos Scaffold
        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: Color.fromRGBO(1, 29, 43, 1),
          titleTextStyle: TextStyle(
            color: Color.fromRGBO(255, 250, 221, 1),
          ),
          actionsIconTheme:
              IconThemeData(color: Color.fromRGBO(255, 250, 221, 1)),
          iconTheme: IconThemeData(color: Color.fromRGBO(255, 250, 221, 1)),
        ),
        textTheme: const TextTheme(
          bodyText1: TextStyle(color: Color.fromRGBO(255, 250, 221, 1)),
          bodyText2: TextStyle(color: Color.fromRGBO(255, 250, 221, 1)),
        ).apply(
            bodyColor: const Color.fromRGBO(255, 250, 221, 1),
            displayColor: const Color.fromRGBO(255, 250, 221, 1)),
        buttonTheme: const ButtonThemeData(
          buttonColor: Color(0xFFDC6425), // Cor dos botões
          textTheme: ButtonTextTheme.primary,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: const Color(0xFFDC6425),
            onPrimary: const Color.fromRGBO(255, 250, 221, 1),
          ),
        ),
      ),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.light,
      initialRoute: (isLogged) ? "home" : "login",
      routes: {
        "home": (context) => const HomeScreen(),
        "login": (context) => LoginScreen(),
        //"category-screen": (context) => CategoryScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == "add-category") {
          if(settings.arguments != null){
            Map<String, dynamic> map = settings.arguments as Map<String, dynamic>;
            final Category category = map["category"] as Category;
            return MaterialPageRoute(builder: (context) {
              return AddCategoryScreen(existingCategory: category,);
            });
          }else{
            return MaterialPageRoute(builder: (context){
              return AddCategoryScreen();
            });
          }
        }else if(settings.name == "category-screen"){
          if(settings.arguments != null){
            Map<String, dynamic> map = settings.arguments as Map<String, dynamic>;
            final Category category = map["category"] as Category;
            return MaterialPageRoute(builder: (context) {
              return CategoryScreen(innerCategory: category,);
            });
          }
        }
        return null;
      },
    );
  }
}
