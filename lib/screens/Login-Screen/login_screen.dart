import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(1, 29, 43, 1),
      body: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.all(32),
        decoration: const BoxDecoration(color: Color.fromRGBO(1, 29, 43, 1)),
        child: Form(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset(
                    "assets/images/logoMyRecipes.jpg",
                    fit: BoxFit.fill,
                  ),
                  const Text("Login or Register", style: TextStyle(fontWeight: FontWeight.bold,color: Color.fromRGBO(255, 250, 221, 1))),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      label: Text("E-mail",style: TextStyle(fontWeight: FontWeight.bold,color: Color.fromRGBO(255, 250, 221, 1))),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  TextFormField(
                    controller: _passController,
                    decoration: const InputDecoration(label: Text("Password", style: TextStyle(fontWeight: FontWeight.bold,color: Color.fromRGBO(255, 250, 221, 1)))),
                    keyboardType: TextInputType.visiblePassword,
                    maxLength: 16,
                    obscureText: true,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      //TO-DO
                      //login(context);
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: const Color(0xFFFFFADD), backgroundColor: const Color(0xFFDC6425),  // RGB(255,250,221)
                    ),
                    child: const Text("Let's cook!", style: TextStyle(fontWeight: FontWeight.bold,color: Color.fromRGBO(255, 250, 221, 1)) ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
