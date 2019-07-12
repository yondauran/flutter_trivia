import 'package:html_unescape/html_unescape.dart';

class TriviaTextParser {
  var unescape = HtmlUnescape();

  TriviaTextParser();

  parseText(String text) {
    var parsedText = unescape.convert(text);

    return parsedText;
  }
}
