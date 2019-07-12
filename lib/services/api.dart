import 'dart:convert';

import 'package:flutter_trivia/models/api_response.dart';
import 'package:flutter_trivia/models/categories.dart';
import 'package:flutter_trivia/models/category_question_count.dart';
import 'package:http/http.dart' as http;

class Api {
  final client = http.Client();
  String _baseUrl = "https://opentdb.com/api.php?";
  String _categoriesUrl = "https://opentdb.com/api_category.php";
  String _categoryQuestionCountUrl =
      "https://opentdb.com/api_count.php?category=";

  Future<List<TriviaCategory>> getCategories() async {
    var res = await client.get(_categoriesUrl);
    Categories categories;

    if (res.statusCode == 200) categories = Categories.fromJson(res.body);
    return categories.triviaCategories;
  }

  Future<Counts> getCategoryQuestionCount(int id) async {
    var res = await client.get(_categoryQuestionCountUrl + id.toString());
    CategoryQuestionCount questionCount;

    if (res.statusCode == 200)
      questionCount = CategoryQuestionCount.fromJson(res.body);

    return questionCount.counts;
  }

  Future<List<Question>> getQuestions(
      dynamic category, String difficulty, String type, int amount) async {
    var questionsUrl = _baseUrl;

    questionsUrl += "amount=$amount";

    if (category != "any") questionsUrl += "&category=${category.toString()}";
    if (difficulty != "any") questionsUrl += "&difficulty=$difficulty";
    if (type != "any") questionsUrl += "&type=$type";

    print(questionsUrl);
    var res = await client.get(questionsUrl);
    var body = json.decode(res.body);

    var apiResponse = ApiResponse.fromJson(body);

    return apiResponse.questions;
  }
}
