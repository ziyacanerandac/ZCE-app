import 'dart:convert';

import 'package:zce/models/article_model.dart';
import 'package:http/http.dart' as http;

class News {
  List<ArticleModel> news=[];
Future<void> getNews() async{
  String url="https://newsapi.org/v2/top-headlines?country=tr&apiKey=71533bc46856475d8fe29f37c1647f1b";

  var response= await http.get(url);
  var jsondata=jsonDecode(response.body);
  if(jsondata['status'] =="ok"){
    jsondata["articles"].forEach((element){
if(element["urlToImage"] != null && element['description']!=null){
  ArticleModel articleModel =ArticleModel(
title: element['title'],
    author: element["author"],
    description: element["description"],
    url: element["url"],
  urlToImage:element["urlToImage"],

    content: element["context"],
  );
  news.add(articleModel);
}
    });
  }
}
}

class CategoryNewsClass {
  List<ArticleModel> news=[];
  Future<void> getNews(String category ) async{
    String url="https://newsapi.org/v2/top-headlines?category=$category&country=tr&apiKey=71533bc46856475d8fe29f37c1647f1b";

    var response= await http.get(url);
    var jsondata=jsonDecode(response.body);
    if(jsondata['status'] =="ok"){
      jsondata["articles"].forEach((element){
        if(element["urlToImage"] != null && element['description']!=null){
          ArticleModel articleModel =ArticleModel(
            title: element['title'],
            author: element["author"],
            description: element["description"],
            url: element["url"],
            urlToImage:element["urlToImage"],

            content: element["context"],
          );
          news.add(articleModel);
        }
      });
    }
  }
}