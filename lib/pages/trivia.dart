import 'package:flutter/material.dart';
import 'package:flutter_trivia/models/categories.dart';
import 'package:flutter_trivia/models/questions.dart';
import 'package:flutter_trivia/route_arguments/trivia_arguments.dart';
import 'package:flutter_trivia/widgets/choice.dart';
import 'package:provider/provider.dart';

class Trivia extends StatelessWidget {
  final Map<int, String> indexToLetter = {0: 'a', 1: 'b', 2: 'c', 3: 'd'};
  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    final TriviaArguments args = ModalRoute.of(context).settings.arguments;

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
        body: PageView.builder(
          controller: _controller,
          itemCount: args.questions.length,
          itemBuilder: (context, index) {
            return Container(
              padding: EdgeInsets.all(8),
              child: Consumer<Questions>(builder: (context, data, _) {
                List<String> answers =
                    List.from(data.questions[index].incorrectAnswers)
                      ..add(data.questions[index].correctAnswer)
                      ..shuffle();

                return Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        data.questions[index].question + index.toString(),
                        style: TextStyle(fontSize: 38),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: 48,
                    ),
                    if (data.questions != null)
                      Column(
                        children: <Widget>[
                          for (var ans in answers)
                            new Choice(
                              question: data.questions[index].question,
                              letter: indexToLetter[answers.indexOf(ans)],
                              text: ans,
                              callback: nextQuestion,
                            ),
                          // new Choice(letter: "a", text: "Hello"),
                          // new Choice(letter: "b", text: "How"),
                          // new Choice(letter: "c", text: "Are"),
                          // new Choice(letter: "d", text: "You?"),
                        ],
                      ),
                  ],
                );
              }),
            );
          },
        ),
      ),
    );
  }
}
