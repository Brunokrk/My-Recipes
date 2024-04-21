import 'dart:convert';
import 'dart:io';

import 'package:my_recipes_app/services/web_client.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  String url = WebClient.url; //atributo estático, não precisa de instância
  http.Client client =
      WebClient().client; //client com http_interceptors e timeout definido

  //TO-DO: login

  Future<bool> login({required String email, required String password}) async {
    final Map<String, String> requestBody = {
      'email': email,
      'password': password,
    };
    http.Response response = await client.post(
      Uri.parse('${url}login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(requestBody),
    );
    if(response.statusCode != 200){
      final String errorCase = json.decode(response.body);
      switch (errorCase){
        case "Cannot find user":
          throw UserNotFindException();
      }
      throw HttpException(response.body);
    }

    saveUserInfos(response.body);// -> salva usuário localmente
    return true;
  }

  Future<bool> register(
      {required String email, required String password}) async {
    final Map<String, String> requestBody = {
      'email': email,
      'password': password,
    };
    http.Response response = await client.post(
      Uri.parse('${url}register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(requestBody),
    );
    if(response.statusCode !=201){
      throw HttpException(response.body);
    }

    saveUserInfos(response.body); //-> salva usuário localmente
    return true;
  }

  //TO-DO
  saveUserInfos(String body)async{
    Map<String, dynamic> map = json.decode(body);
    String token = map["accessToken"];
    String email = map["user"]["email"];
    int id = map["user"]["id"];

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("accessToken", token);
    prefs.setString("email", email);
    prefs.setInt("id", id);
  }

}
class UserNotFindException implements Exception {}