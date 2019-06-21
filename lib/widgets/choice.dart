import 'package:flutter/material.dart';
import 'package:flutter_trivia/models/questions.dart';
import 'package:provider/provider.dart';

class Choice extends StatelessWidget {
  final String _question;
  final String _letter;
  final String _text;
  final Function callback;

  const Choice(
      {Key key,
      @required String question,
      @required String letter,
      @required String text,
      this.callback})
      : this._question = question,
        this._letter = letter,
        this._text = text,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    var _questions = Provider.of<Questions>(context);

    return Card(
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
          leading: Text(_letter + ")"),
          title: Text(_text),
        ),
      ),
    );
  }
}
