// lib/services/api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/jsonfile.dart';

class ApiService {
  final String apiUrl;

  ApiService(this.apiUrl);

  Future<List<Post>> getPosts() async {
    final response = await http.get(Uri.parse(apiUrl + '/posts'));

    if (response.statusCode == 200) {
      Iterable list = json.decode(response.body);
      return list.map((model) => Post.fromJson(model)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }
}
