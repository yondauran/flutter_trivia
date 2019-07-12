import 'package:flutter/material.dart';
import 'package:flutter_trivia/helpers/trivia_text_parser.dart';
import 'package:flutter_trivia/models/questions.dart';
import 'package:flutter_trivia/route_arguments/trivia_arguments.dart';
import 'package:flutter_trivia/services/locator.dart';
import 'package:flutter_trivia/widgets/choice.dart';
import 'package:provider/provider.dart';

class Trivia extends StatelessWidget {
  final Map<int, String> indexToLetter = {0: 'a', 1: 'b', 2: 'c', 3: 'd'};
  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    final TriviaArguments args = ModalRoute.of(context).settings.arguments;
    final TriviaTextParser textParser = locator.get<TriviaTextParser>();

    void nextQuestion(Questions provider) {
      if (_controller.page == args.questions.length - 1) {
        Navigator.pushReplacementNamed(
          context,
          "/results",
          arguments: TriviaArguments(questions: provider.questions),
        );
      } else {
        _controller.nextPage(
            duration: Duration(milliseconds: 500), curve: Curves.fastOutSlowIn);
      }
    }

    return ChangeNotifierProvider<Questions>(
      builder: (_) => Questions(args.questions),
      child: Scaffold(
        appBar: AppBar(
          title: Text(args.questions[0].category),
        ),
        body: SafeArea(
          child: PageView.builder(
            physics: NeverScrollableScrollPhysics(),
            controller: _controller,
            itemCount: args.questions.length,
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.all(8),
                child: Consumer<Questions>(
                  builder: (context, data, _) {
                    List<String> answers;

                    if (data.questions[index].type == "multiple") {
                      answers =
                          List.from(data.questions[index].incorrectAnswers)
                            ..add(data.questions[index].correctAnswer)
                            ..shuffle();
                    } else {
                      answers = ["True", "False"];
                    }

                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Question ${index + 1} of ${data.questions.length}",
                            style: TextStyle(
                              color: Colors.blueGrey[300],
                              fontSize: 22,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 24,
                          ),
                          child: Text(
                            textParser
                                .parseText(data.questions[index].question),
                            style: TextStyle(fontSize: 34),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        if (data.questions != null &&
                            data.questions[index].type == "multiple")
                          Column(
                            // mainAxisAlignment: MainAxisAlignment.end,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              for (var ans in answers)
                                new Choice(
                                  question: data.questions[index].question,
                                  letter: indexToLetter[answers.indexOf(ans)],
                                  text: textParser.parseText(ans),
                                  type: "multiple",
                                  callback: nextQuestion,
                                ),
                            ],
                          )
                        else if (data.questions != null &&
                            data.questions[index].type == "boolean")
                          Column(
                            children: <Widget>[
                              for (var choice in answers)
                                new Choice(
                                  question: data.questions[index].question,
                                  text: choice,
                                  type: "boolean",
                                  callback: nextQuestion,
                                ),
                            ],
                          )
                      ],
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
