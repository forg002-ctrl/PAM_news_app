import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

import 'package:pam_news_app/Data//get_news.dart';

class GettingNews {
  GetNews parseNews(String responseBody) {
    GetNews news = GetNews.fromJson(jsonDecode(responseBody));
    return news;
  }

  Future<GetNews> getNews(String id) async {
    String fileName = "news_$id.json";

    var dir = await getTemporaryDirectory();

    File file = File("${dir.path}/$fileName");
    if (file.existsSync()) {
      log("Loading GetNews with $id from cache");
      var response = file.readAsStringSync();

      return parseNews(response);
    } else {
      log("Loading GetNews with $id from API");
      var response = await http
          .get(Uri.parse(
          'https://news-app-api.k8s.devebs.net/articles/$id'));

      if (response.statusCode == 200) {
        file.writeAsStringSync(response.body, flush: true, mode: FileMode.write);
        return parseNews(response.body);
      } else {
        throw Exception('Failed to load news');
      }
    }
  }
}