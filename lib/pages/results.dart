import 'package:flutter/material.dart';
import 'package:flutter_trivia/models/api_response.dart';
import 'package:flutter_trivia/route_arguments/trivia_arguments.dart';

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
      appBar: AppBar(
        title: Text("Results"),
      ),
      body: SafeArea(
        child: Column(
          // mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 8),
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
            Expanded(
              child: PageView.builder(
                // controller: PageController(viewportFraction: 0.8),
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
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            questions[i].question,
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
                                  "${indexToLetter[answers.indexOf(ans)]}) $ans",
                                  style: TextStyle(
                                    fontSize: 18,
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
