import 'package:flutter/material.dart';
import 'package:flutter_trivia/models/questions.dart';
import 'package:flutter_trivia/services/api.dart';
import 'package:provider/provider.dart';

class Choice extends StatelessWidget {
  final String _letter;
  final String _text;

  const Choice({Key key, @required String letter, @required String text})
      : this._letter = letter,
        this._text = text,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () async {},
        child: ListTile(
          leading: Text(_letter + ")"),
          title: Text(_text),
        ),
      ),
    );
  }
}
