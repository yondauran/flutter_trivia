import 'package:flutter/material.dart';
import 'package:flutter_trivia/models/api_response.dart';
import 'package:flutter_trivia/route_arguments/trivia_arguments.dart';
import 'package:flutter_trivia/widgets/choice.dart';

class Results extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TriviaArguments args = ModalRoute.of(context).settings.arguments;
    final List<Question> questions = args.questions;
    final Map<int, String> indexToLetter = {0: 'a', 1: 'b', 2: 'c', 3: 'd'};

    int getCorrectAnswers() {
      return questions
          .where((val) => val.selectedAnswer == val.correctAnswer)
          .length;
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          // mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Results: \n",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text:
                        "${getCorrectAnswers()} out of ${questions.length} correct",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: PageView.builder(
                // controller: PageController(viewportFraction: 0.8),
                itemCount: questions.length,
                itemBuilder: (context, i) {
                  List<String> answers =
                      List.from(questions[i].incorrectAnswers)
                        ..add(questions[i].correctAnswer)
                        ..shuffle();

                  return Container(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            questions[i].question + i.toString(),
                            style: TextStyle(fontSize: 38),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          height: 48,
                        ),
                        if (questions != null)
                          Column(
                            children: <Widget>[
                              for (var ans in answers)
                                Text(
                                  ans,
                                  style: TextStyle(
                                    color: questions[i].selectedAnswer == ans &&
                                            questions[i].selectedAnswer ==
                                                questions[i].correctAnswer
                                        ? Colors.green
                                        : questions[i].selectedAnswer == ans &&
                                                questions[i].selectedAnswer !=
                                                    questions[i].correctAnswer
                                            ? Colors.red
                                            : Colors.white,
                                  ),
                                )
                              // new Choice(
                              //   question: questions[i].question,
                              //   letter: indexToLetter[answers.indexOf(ans)],
                              //   text: ans,
                              // ),
                            ],
                          ),
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
