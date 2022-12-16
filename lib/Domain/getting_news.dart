import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:pam_news_app/Data//get_news.dart';

class GettingNews {
  GetNews parseNews(String responseBody) {
    GetNews news = GetNews.fromJson(jsonDecode(responseBody));
    return news;
  }

  Future<GetNews> getNews(String id) async {
    var response = await http
        .get(Uri.parse(
        'https://news-app-api.k8s.devebs.net/articles/$id'));

    if (response.statusCode == 200) {
      return parseNews(response.body);
    } else {
      throw Exception('Failed to load news');
    }
  }
}