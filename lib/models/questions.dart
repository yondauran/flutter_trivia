import 'package:flutter/material.dart';
import 'package:flutter_trivia/models/api_response.dart';
import 'package:flutter_trivia/services/api.dart';

class Questions with ChangeNotifier {
  List<Question> _questions = [];

  Questions();

  void getQuestions() async {
//    var res = await Api().getQuestions();
//    _questions = res;
    notifyListeners();
  }

  List<Question> get questions => _questions;

  setQuestions(List<Question> questions) {
    _questions = questions;
    notifyListeners();
  }
}
