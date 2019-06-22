import 'package:flutter/material.dart';
import 'package:flutter_trivia/models/questions.dart';
import 'package:flutter_trivia/route_arguments/trivia_arguments.dart';
import 'package:flutter_trivia/widgets/choice.dart';
import 'package:provider/provider.dart';
import 'package:html_unescape/html_unescape_small.dart';

class Trivia extends StatelessWidget {
  final Map<int, String> indexToLetter = {0: 'a', 1: 'b', 2: 'c', 3: 'd'};
  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    final TriviaArguments args = ModalRoute.of(context).settings.arguments;
    var unescape = new HtmlUnescape();

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
          physics: NeverScrollableScrollPhysics(),
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
                        unescape.convert(
                            data.questions[index].question + index.toString()),
                        style: TextStyle(fontSize: 34),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    if (data.questions != null)
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            for (var ans in answers)
                              new Choice(
                                question: data.questions[index].question,
                                letter: indexToLetter[answers.indexOf(ans)],
                                text: ans,
                                callback: nextQuestion,
                              ),
                          ],
                        ),
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
