import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:my_recipes_app/routes/route_generator.dart';
import 'package:my_recipes_app/screens/Home-Screen/home_screen.dart';
import 'package:my_recipes_app/screens/Login-Screen/login_screen.dart';
import 'package:my_recipes_app/theme/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  bool isLogged = await verifyToken();
  runApp(MyApp(isLogged: isLogged));
}

Future<bool> verifyToken() async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("accessToken");
    return token != null;
  } catch (e) {
    //print('Failed to load token: $e');
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
      theme: appTheme(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.light,
      initialRoute: isLogged ? "home" : "login",
      routes: {
        "home": (context) => const HomeScreen(),
        "login": (context) => LoginScreen(),
      },
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}