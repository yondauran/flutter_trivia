import 'package:flutter/material.dart';
import 'package:flutter_trivia/models/questions.dart';
import 'package:flutter_trivia/widgets/choice.dart';
import 'package:provider/provider.dart';

class Trivia extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Questions>(
      builder: (_) => Questions(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Answer de qestions"),
        ),
        body: Container(
          padding: EdgeInsets.all(8),
          child: Consumer<Questions>(
            builder: (context, questions, _) => Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    if (questions.questions.isEmpty)
                      _buildSubmitButton(questions),
                    if (questions.questions.isNotEmpty) Text("AYEEEE"),
                    new Choice(letter: "a", text: "Hello"),
                    new Choice(letter: "b", text: "How"),
                    new Choice(letter: "c", text: "Are"),
                    new Choice(letter: "d", text: "You?"),
                  ],
                ),
          ),
        ),
      ),
    );
  }

  _buildSubmitButton(Questions questions) {
    return RaisedButton(
      onPressed: () {
        questions.getQuestions();
      },
      child: Text("Get Questions"),
    );
  }
}
