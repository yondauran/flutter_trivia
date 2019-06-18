import 'package:flutter/material.dart';
import 'package:flutter_trivia/models/api_response.dart';
import 'package:flutter_trivia/models/questions.dart';
import 'package:flutter_trivia/route_arguments/trivia_arguments.dart';
import 'package:flutter_trivia/widgets/choice.dart';
import 'package:provider/provider.dart';

class Trivia extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TriviaArguments args = ModalRoute.of(context).settings.arguments;

    return ChangeNotifierProvider<Questions>(
      builder: (_) => Questions(args.questions),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Answer de qestions"),
        ),
        body: PageView.builder(
          itemCount: args.questions.length,
          itemBuilder: (context, index) {
            return Container(
              padding: EdgeInsets.all(8),
              child: Consumer<Questions>(
                builder: (context, data, _) => Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        if (data.questions != null) ...[
                          new Choice(letter: "a", text: "Hello"),
                          new Choice(letter: "b", text: "How"),
                          new Choice(letter: "c", text: "Are"),
                          new Choice(letter: "d", text: "You?"),
                        ],
                        Text("Aye $index")
                      ],
                    ),
              ),
            );
          },
        ),
      ),
    );
  }
}
