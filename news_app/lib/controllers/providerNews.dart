import 'package:flutter/material.dart';
import 'package:news_app/network/api_call.dart';
import 'package:news_app/utils/constants.dart';

import '../models/news_model.dart';

class NewsPorvider extends ChangeNotifier {
  List<Article> _article = [];

  List<Article> get listofArticles => _article;
  bool isdata = false;

  Future<void> getallArticles() async {
    Map<String, dynamic> responsebody = await ApiCall().get(Constantss.allnews);

    List<dynamic> data = responsebody['articles'];

    print("data = $data");

    _article.clear();
    data.forEach((data) {
      listofArticles.add(Article.fromJson(data));
    });

    isdata = true;
    notifyListeners();
  }

  Future<void> getSingleNews(String keyword) async {
    Map<String, dynamic> responseBody =
        await ApiCall().getNewsbykeyword(keyword);
    List<dynamic> data = responseBody['articles'];

    _article.clear();
    data.forEach((data) {
      _article.add(Article.fromJson(data));
    });

    isdata = true;
    notifyListeners();
  }
}
