import 'package:my_recipes_app/services/web_client.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class CategoryService {
  String url = WebClient.url;
  http.Client client =  WebClient().client;

  static const String resource = "categories/";

  String getUrl() {
    return "$url$resource";
  }

  //TODO: REGISTER
  

  //TODO: EDIT
  //TODO: GETALL
  //TODO: DELETE

}