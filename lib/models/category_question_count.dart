import 'dart:convert';

import 'package:flutter/material.dart';

class CategoryQuestionCount with ChangeNotifier {
  int categoryId;
  Counts counts;

  CategoryQuestionCount({
    this.categoryId,
    this.counts,
  });

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
