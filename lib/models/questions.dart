import 'package:flutter/material.dart';
import 'package:flutter_trivia/models/api_response.dart';

class Questions with ChangeNotifier {
  List<Question> _questions = [];

  Questions(this._questions);

  List<Question> get questions => _questions;

  set questions(List<Question> questions) {
    _questions = questions;
    notifyListeners();
  }
}
