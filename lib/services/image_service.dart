import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class ImageService{
  final String apiKey = dotenv.env['PEXELS_API_KEY']!;
  Future<String> fetchImage(String query) async {
    var url = Uri.parse('https://api.pexels.com/v1/search?query=$query&per_page=1');
    var headers = {
      'Authorization': apiKey
    };
    var response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      if (data['photos'].isNotEmpty) {
        return data['photos'][0]['src']['medium']; // Retorna a URL da única imagem
      } else {
        throw Exception('No images found');
      }
    } else {
      throw Exception('Failed to load image');
    }
  }

}