import 'package:my_recipes_app/services/web_client.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService{
  String url = WebClient.url; //atributo estático, não precisa de instancia
  http.Client client = WebClient().client; //client com http_interceptors e timeout definido

  //TO-DO: login register

}