import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_recipes_app/screens/Home-Screen/home_screen.dart';
import 'package:my_recipes_app/screens/Login-Screen/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Journal',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        //paleta primária
        primarySwatch: Colors.grey,
        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: Colors.black,
          titleTextStyle: TextStyle(
            color: Colors.white,
          ),
          actionsIconTheme: IconThemeData(color: Colors.white),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        textTheme: GoogleFonts.bitterTextTheme(),
      ),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.light,
      initialRoute:"login",
      routes: {
        "home": (context) =>  HomeScreen(),
        "login": (context) => LoginScreen(),
      },
      onGenerateRoute: (settings){
        return null;
      },
    );
  }
}
