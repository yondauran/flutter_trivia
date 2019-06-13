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

class ApiCategory extends BaseOptions {
  ApiCategory() {
    options.add(ApiOption("Entertainment: Books", 10));
    options.add(ApiOption("Entertainment: Film", 11));
    options.add(ApiOption("Entertainment: Music", 12));
    options.add(ApiOption("Entertainment: Musicals & Theatres", 13));
    options.add(ApiOption("Entertainment: Television", 14));
    options.add(ApiOption("Entertainment: Video Games", 15));
    options.add(ApiOption("Entertainment: Board Games", 16));
    options.add(ApiOption("Science & Nature", 17));
    options.add(ApiOption("Science: Computers", 18));
    options.add(ApiOption("Science: Mathematics", 19));
    options.add(ApiOption("Mythology", 20));
    options.add(ApiOption("Sports", 21));
    options.add(ApiOption("Geography", 22));
    options.add(ApiOption("History", 23));
    options.add(ApiOption("Politics", 24));
    options.add(ApiOption("Art", 25));
    options.add(ApiOption("Celebrities", 26));
    options.add(ApiOption("Animals", 27));
    options.add(ApiOption("Vehicles", 28));
    options.add(ApiOption("Entertainment: Comics", 29));
    options.add(ApiOption("Science: Gadgets", 30));
    options.add(ApiOption("Entertainment: Japanese Anime & Manga", 31));
    options.add(ApiOption("Entertainment: Cartoon & Animations", 32));

    // Sort Alphabetically (UNTESTED)
    options.sort((a, b) => a.text.compareTo(b.text));

    // Insert default option at start of list
    options.insert(0, ApiOption("Any Category", "any"));

    selected = options[0];
  }
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