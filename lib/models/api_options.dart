class ApiOption {
  final String text;
  final dynamic value;

  ApiOption(this.text, this.value);
}

class BaseOptions {
  final List<ApiOption> options = List<ApiOption>();
  ApiOption selected;

  BaseOptions();
}

class ApiDifficulty extends BaseOptions {
  ApiDifficulty() {
    options.add(ApiOption("Any Difficulty", "any"));
    options.add(ApiOption("Easy", "easy"));
    options.add(ApiOption("Medium", "medium"));
    options.add(ApiOption("Hard", "hard"));

    selected = options[0];
  }
}

class TriviaType extends BaseOptions {
  TriviaType() {
    options.add(ApiOption("Any", "any"));
    options.add(ApiOption("Multiple Choice", "multiple"));
    selected = options[0];
  }
}
