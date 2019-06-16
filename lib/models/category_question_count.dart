import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_trivia/services/api.dart';
import 'package:flutter_trivia/services/locator.dart';

class CategoryQuestionCount with ChangeNotifier {
  int categoryId;
  double _min, _max, _amount;
  Counts counts;

  CategoryQuestionCount({
    this.categoryId,
    this.counts,
  });

  double get min => _min;
  double get max => _max;
  double get amount => _amount;

  set amount(double value) {
    _amount = value;
    notifyListeners();
  }

  Future<bool> setMinMaxAndAmount(String difficulty) async {
    _min = math.min(counts.totalHardQuestionCount.toDouble(),
        counts.totalMediumQuestionCount.toDouble());
    _min = math.min(_min, counts.totalEasyQuestionCount.toDouble());

    if (_min - 5 > 10)
      _min = 10;
    else
      _min = 5;

    if (difficulty == "easy")
      _max = counts.totalEasyQuestionCount.toDouble();
    else if (difficulty == "medium")
      _max = counts.totalMediumQuestionCount.toDouble();
    else if (difficulty == "hard")
      _max = counts.totalHardQuestionCount.toDouble();
    else if (difficulty == "any") _max = counts.totalQuestionCount.toDouble();

    if (_min > 10)
      _amount = 10;
    else if (_min + 5 < _max)
      _amount = _min + 5;
    else
      _amount = _min;

    notifyListeners();
    return true;
  }

  bool ensureNotNull() {
    if (_amount != null && _min != null && _max != null && counts != null) {
      return true;
    } else
      return false;
  }

  Future<bool> getQuestionCount(int id) async {
    var questionCount = await locator.get<Api>().getCategoryQuestionCount(id);
    categoryId = id;
    counts = questionCount;
    print(counts.totalQuestionCount);

    notifyListeners();
    return true;
  }

  factory CategoryQuestionCount.fromJson(String str) {
    var jsonMap = json.decode(str);

    return CategoryQuestionCount(
      categoryId: jsonMap["category_id"],
      counts: Counts.fromMap(jsonMap["category_question_count"]),
    );
  }

  String toJson() {
    return json.encode({
      "category_id": categoryId,
      "category_question_count": counts.toMap(),
    });
  }
}

class Counts {
  int totalQuestionCount;
  int totalEasyQuestionCount;
  int totalMediumQuestionCount;
  int totalHardQuestionCount;

  Counts({
    this.totalQuestionCount,
    this.totalEasyQuestionCount,
    this.totalMediumQuestionCount,
    this.totalHardQuestionCount,
  });

  factory Counts.fromJson(String str) => Counts.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Counts.fromMap(Map<String, dynamic> json) => new Counts(
        totalQuestionCount: json["total_question_count"],
        totalEasyQuestionCount: json["total_easy_question_count"],
        totalMediumQuestionCount: json["total_medium_question_count"],
        totalHardQuestionCount: json["total_hard_question_count"],
      );

  Map<String, dynamic> toMap() => {
        "total_question_count": totalQuestionCount,
        "total_easy_question_count": totalEasyQuestionCount,
        "total_medium_question_count": totalMediumQuestionCount,
        "total_hard_question_count": totalHardQuestionCount,
      };
}
