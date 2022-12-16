import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:pam_news_app/Data/featured_news.dart';

class ListingFeaturedNews {
  List<FeaturedNews> parseFeaturedNews(String responseBody) {
    var parsedJson = jsonDecode(responseBody)["results"] as List;
    List<FeaturedNews> list = parsedJson.map((json) => FeaturedNews.fromJson(json)).toList();
    return list;
  }

  Future<List<FeaturedNews>> listFeaturedNews() async {
      var response = await http
          .get(Uri.parse(
          'https://news-app-api.k8s.devebs.net/articles?is_featured=true'));

      if (response.statusCode == 200) {
        return parseFeaturedNews(response.body);
      } else {
        throw Exception('Failed to load featured nes');
      }
  }
}



