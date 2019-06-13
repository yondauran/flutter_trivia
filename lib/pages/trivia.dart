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
        appBar: AppBar(title: Text("Answer de qestions"),),
        body: Container(
          padding: EdgeInsets.all(8),
          child: Consumer<Questions>(
            builder: (context, questions, _) => Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                if (questions.questions.isEmpty)
                  _buildSubmitButton(questions),
                if (questions.questions.isNotEmpty)
                  Text("AYEEEE"),
                new Choice(number: 1, text: "Hello"),
                new Choice(number: 2, text: "How"),
                new Choice(number: 3, text: "Are"),
                new Choice(number: 4, text: "You?"),
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