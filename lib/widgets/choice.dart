import 'package:flutter/material.dart';
import 'package:flutter_trivia/helpers/trivia_text_parser.dart';
import 'package:flutter_trivia/models/questions.dart';
import 'package:flutter_trivia/services/locator.dart';
import 'package:provider/provider.dart';

class Choice extends StatelessWidget {
  final String _question;
  final String _letter;
  final String _text;
  final String _type;
  final Function callback;

  static TriviaTextParser textParser = locator.get<TriviaTextParser>();

  Choice(
      {Key key,
      @required String question,
      String letter,
      @required String text,
      @required String type,
      this.callback})
      : this._letter = letter,
        this._text = text,
        this._type = type,
        this._question = question,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    var _questions = Provider.of<Questions>(context);

    return Card(
      color: _type == "boolean"
          ? (_text == "True" ? Colors.green : Colors.red)
          : null,
      child: InkWell(
        onTap: () async {
          var currentQuestion = _questions.questions
              .firstWhere((val) => val.question == _question);
          print(currentQuestion.correctAnswer == _text ? true : false);
          _questions.questions
              .firstWhere((val) => val == currentQuestion)
              .selectedAnswer = _text;

          callback(_questions);
        },
        child: ListTile(
          leading: _letter != null ? Text(_letter + ")") : null,
          title: Text(
            _type == "boolean" ? _text : textParser.parseText(_text),
            textAlign: _type == "boolean" ? TextAlign.center : TextAlign.start,
          ),
        ),
      ),
    );
  }
}
