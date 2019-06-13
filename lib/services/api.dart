import 'dart:convert';

import 'package:flutter_trivia/models/api_response.dart';
import 'package:http/http.dart' as http;

class Api {
  final client = http.Client();
  String _baseUrl = "https://opentdb.com/api.php?amount=10";

  getQuestions(dynamic category, dynamic difficulty, dynamic type) async {
//    print(category + difficulty + type);
    if (category != "any")
      _baseUrl += "&category=${category.toString()}";
    if (difficulty != "any")
      _baseUrl += "&difficulty=${difficulty.toString()}";
    if (type != "any")
      _baseUrl += "&type=${type.toString()}";

    print(_baseUrl);
//    var res = await client.get("https://opentdb.com/api.php?amount=10&category=18&difficulty=easy&type=multiple");
//    var apiResponse = ApiResponse.fromJson(json.decode(res.body));
//
//    return apiResponse.questions;
  }
}