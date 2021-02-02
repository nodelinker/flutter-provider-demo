import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:provider_demo/model/photo.dart';
import 'package:provider_demo/model/post.dart';

class WebServices {
  fetchPosts(int page) async {
    final url =
        "https://jsonplaceholder.typicode.com/posts?_start=$page&_limit=30";

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final res = jsonDecode(response.body).cast<Map<String, dynamic>>();
      return res.map<Post>((item) => Post.fromJson(item)).toList();
    } else if (response.statusCode == 404) {
      throw Exception("page not found!");
    } else {
      throw Exception("Unable to perform request!");
    }
  }

  fetchPhotos(int page) async {
    final response = await http
        .get("https://jsonplaceholder.typicode.com/photos?_page=$page");

    if (response.statusCode == 200) {
      final res = jsonDecode(response.body).cast<Map<String, dynamic>>();
      return res.map<Photo>((item) => Photo.fromJson(item)).toList();
    } else if (response.statusCode == 404) {
      throw Exception("page not found!");
    } else {
      throw Exception("Unable to perform request!");
    }
  }
}
