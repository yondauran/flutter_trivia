import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_trivia/services/api.dart';
import 'package:flutter_trivia/services/locator.dart';

class Categories with ChangeNotifier {
  List<TriviaCategory> triviaCategories;
  TriviaCategory _selected;
  Api _api = locator.get<Api>();

  Categories({
    this.triviaCategories,
  });

  Future<bool> getCategories() async {
    triviaCategories = await _api.getCategories();
    triviaCategories.sort((a, b) => a.name.compareTo(b.name));
    selected = triviaCategories[0];
    print(selected);
    notifyListeners();
    return true;
  }

  TriviaCategory get selected => _selected;
  set selected(TriviaCategory category) {
    _selected = category;
    print("Selected Category: " + category.toJson());
    notifyListeners();
  }

  factory Categories.fromJson(String jsonRaw) {
    var jsonMap = json.decode(jsonRaw);

    print(jsonMap);

    return Categories(
      triviaCategories: new List<TriviaCategory>.from(
          jsonMap["trivia_categories"].map((x) => TriviaCategory.fromMap(x))),
    );
  }

  String toJson() => json.encode({
        "trivia_categories":
            new List<dynamic>.from(triviaCategories.map((x) => x.toJson())),
      });
}

class TriviaCategory {
  int id;
  String name;

  TriviaCategory({
    this.id,
    this.name,
  });

  factory TriviaCategory.fromMap(Map<String, dynamic> jsonMap) {
    return TriviaCategory(
      id: jsonMap["id"],
      name: jsonMap["name"],
    );
  }

  String toJson() => json.encode({
        "id": id,
        "name": name,
      });
}
