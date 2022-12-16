import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:pam_news_app/Data/list_news.dart';

class ListingNews {
  List<ListNews> parseNews(String responseBody) {
    // Map<String, dynamic>map = json.decode(responseBody);
    // List<dynamic> data = map["results"];
    var parsed = jsonDecode(responseBody)["results"] as List;
    List<ListNews> test = parsed.map((json) => ListNews.fromJson(json)).toList();
    return test;
  }

  Future<List<ListNews>> listNews(int page, int newsPerPage) async {
    var response = await http
        .get(Uri.parse(
        'https://news-app-api.k8s.devebs.net/articles?page=$page&per_page=$newsPerPage'));

    if (response.statusCode == 200) {
      return parseNews(response.body);
    } else {
      throw Exception('Failed to load news');
    }
  }
}