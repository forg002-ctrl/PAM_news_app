import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

import 'package:pam_news_app/Data/list_news.dart';

class ListingNews {
  List<ListNews> parseNews(String responseBody) {
    var parsed = jsonDecode(responseBody)["results"] as List;
    List<ListNews> test = parsed.map((json) => ListNews.fromJson(json)).toList();
    return test;
  }

  Future<List<ListNews>> listNews(int page, int newsPerPage) async {
    String fileName = "news.json";

    var dir = await getTemporaryDirectory();

    File file = File("${dir.path}/$fileName");
    if (file.existsSync()) {
      log("Loading list of news from cache");
      var response = file.readAsStringSync();

      var parsedData = parseNews(response);

      if (parsedData.length != page * newsPerPage) {
        log("Loading list of news from API(not enough news in json file)");
        var response = await http
            .get(Uri.parse(
            'https://news-app-api.k8s.devebs.net/articles?page=$page&per_page=$newsPerPage'));

        if (response.statusCode == 200) {
          return parseNews(response.body);
        } else {
          throw Exception('Failed to load news');
        }
      } else {
        return [for(int i = page*newsPerPage - 1; i > page*newsPerPage - newsPerPage - 1; i--) parsedData[i]];
      }
    } else {
      log("Loading list of news from API");
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
}