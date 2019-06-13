import 'package:flutter/material.dart';
import 'package:flutter_trivia/models/questions.dart';
import 'package:flutter_trivia/services/api.dart';
import 'package:provider/provider.dart';

class Choice extends StatelessWidget {
  final int _number;
  final String _text;

  const Choice({Key key, @required int number, @required String text})
      : this._number = number,
        this._text = text,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () async {
        },
        child: ListTile(
          leading: Text(_number.toString()),
          title: Text(_text),
        ),
      ),
    );
  }
}
