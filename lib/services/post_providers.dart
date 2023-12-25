// lib/providers/post_provider.dart
import 'package:flutter/material.dart';
import 'package:student_login/model/jsonfile.dart';
import 'package:student_login/services/post_providers.dart';
import 'package:student_login/services/services_api.dart';

class PostProvider extends ChangeNotifier {
  final ApiService apiService = ApiService('https://jsonplaceholder.typicode.com');
  List<Post> posts = [];

  Future<void> fetchPosts() async {
    try {
      posts = await apiService.getPosts();
      notifyListeners();
    } catch (e) {
      print('Error fetching posts: $e');
    }
  }
}
