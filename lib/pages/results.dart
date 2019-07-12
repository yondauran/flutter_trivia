import 'package:flutter/material.dart';
import 'package:flutter_trivia/helpers/trivia_text_parser.dart';
import 'package:flutter_trivia/models/api_response.dart';
import 'package:flutter_trivia/route_arguments/trivia_arguments.dart';
import 'package:flutter_trivia/services/locator.dart';

class Results extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TriviaArguments args = ModalRoute.of(context).settings.arguments;
    final List<Question> questions = args.questions;
    final Map<int, String> indexToLetter = {0: 'a', 1: 'b', 2: 'c', 3: 'd'};
    final textParser = locator.get<TriviaTextParser>();

    int getCorrectAnswers() {
      return questions
          .where((val) => val.selectedAnswer == val.correctAnswer)
          .length;
    }

    Color getChoiceColors(String selected, String correct, String choice) {
      if (choice == selected) {
        if (choice == correct)
          return Colors.green;
        else
          return Colors.red;
      } else {
        if (choice == correct)
          return Colors.green;
        else
          return Colors.white;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Results"),
      ),
      body: SafeArea(
        child: Column(
          // mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 8),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(fontSize: 24),
                    children: [
                      TextSpan(
                        text: "You got ",
                      ),
                      TextSpan(
                        text: getCorrectAnswers().toString(),
                        style: TextStyle(
                          color: Colors.orange[300],
                        ),
                      ),
                      TextSpan(
                        text: " out of ",
                      ),
                      TextSpan(
                        text: questions.length.toString(),
                        style: TextStyle(
                          color: Colors.orange[700],
                        ),
                      ),
                      TextSpan(text: " correct!")
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: PageController(viewportFraction: 0.9),
                itemCount: questions.length,
                itemBuilder: (context, i) {
                  List<String> answers =
                      List.from(questions[i].incorrectAnswers)
                        ..add(questions[i].correctAnswer);

                  return Container(
                    margin: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.blueGrey[800],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(
                          "Question ${i + 1}",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueGrey[300],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            textParser.parseText(questions[i].question),
                            style: TextStyle(fontSize: 32),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          height: 48,
                        ),
                        if (questions != null)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              for (var ans in answers)
                                Text(
                                  "${indexToLetter[answers.indexOf(ans)]}) ${textParser.parseText(ans)}",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: getChoiceColors(
                                      questions[i].selectedAnswer,
                                      questions[i].correctAnswer,
                                      ans,
                                    ),
                                  ),
                                )
                            ],
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),
            RaisedButton(
              child: Text("Pick again"),
              onPressed: () {
                Navigator.of(context).pushNamed("/");
              },
              color: Theme.of(context).buttonColor,
            )
          ],
        ),
      ),
    );
  }
}
