import 'package:flutter/material.dart';
import 'package:flutter_trivia/models/categories.dart';
import 'package:flutter_trivia/models/category_question_count.dart';
import 'package:flutter_trivia/pages/results.dart';
import 'package:flutter_trivia/pages/trivia.dart';
import 'package:flutter_trivia/route_arguments/trivia_arguments.dart';
import 'package:flutter_trivia/services/api.dart';
import 'package:flutter_trivia/services/locator.dart';
import 'package:provider/provider.dart';
import 'models/api_options.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.blueAccent,
        scaffoldBackgroundColor: Colors.blueGrey[900],
        brightness: Brightness.dark,
        cardColor: Colors.blueGrey[800],
      ),
      routes: {
        '/': (context) => MultiProvider(
              providers: [
                ChangeNotifierProvider<Categories>.value(
                  value: Categories(),
                ),
                ChangeNotifierProvider<CategoryQuestionCount>.value(
                  value: CategoryQuestionCount(),
                ),
              ],
              child: HomePage(),
            ),
        '/trivia': (context) => Trivia(),
        '/results': (context) => Results()
      },
      initialRoute: '/',
    );
  }
}

class HomePage extends StatelessWidget {
  final ApiDifficulty _difficulty = ApiDifficulty();
  final TriviaType _type = TriviaType();

  @override
  Widget build(BuildContext context) {
    var _categories = Provider.of<Categories>(context);
    var _categoryQuestionCount = Provider.of<CategoryQuestionCount>(context);

    getCategories() async {
      if (_categories.triviaCategories == null) {
        var res = await _categories.getCategories();
        print("asdf" + res.toString());
        await _categoryQuestionCount.getQuestionCount(_categories.selected.id);
        await _categoryQuestionCount
            .setMinMaxAndAmount(_difficulty.selected.value);
      }
    }

    getCategories();

    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            if (!_categoryQuestionCount.ensureNotNull()) ...[
              CircularProgressIndicator(),
            ] else ...[
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 60),
                    child: Text(
                      "It's Trivia Time!",
                      style: TextStyle(
                        fontFamily: "Pacifico",
                        fontSize: 32,
                      ),
                    ),
                  ),
                  Text("Category"),
                  SizedBox(
                    height: 56,
                    child: DropdownButton<TriviaCategory>(
                      hint: Text("Select a Category"),
                      value: _categories.selected,
                      isExpanded: true,
                      onChanged: (val) async {
                        _categories.selected = val;
                        await _categoryQuestionCount
                            .getQuestionCount(_categories.selected.id);
                        _categoryQuestionCount
                            .setMinMaxAndAmount(_difficulty.selected.value);
                      },
                      items: _categories.triviaCategories != null
                          ? _categories.triviaCategories
                              .map(
                                (o) => DropdownMenuItem<TriviaCategory>(
                                      value: o,
                                      child: Text(o.name),
                                    ),
                              )
                              .toList()
                          : null,
                    ),
                  ),
                  SizedBox(height: 28)
                ],
              ),
              OptionsSelector(_difficulty, "Difficulty", "Select a Difficulty"),
              OptionsSelector(_type, "Type", "Select a Type"),
              Column(
                children: <Widget>[
//                  Text("Amount"),
                  RichText(
                    text: TextSpan(children: [
                      TextSpan(text: "Amount: "),
                      TextSpan(
                        text: _categoryQuestionCount.amount.toStringAsFixed(0),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).accentColor,
                        ),
                      )
                    ]),
                  ),
                  Row(
                    children: <Widget>[
                      Text(_categoryQuestionCount.min.toStringAsFixed(0)),
                      Expanded(
                        child: Slider(
                          activeColor: Colors.blue,
                          inactiveColor: Colors.blue[900],
                          onChanged: (value) {
                            _categoryQuestionCount.amount = value;
                          },
                          onChangeEnd: (value) => print(value),
                          value: _categoryQuestionCount.amount,
                          max: _categoryQuestionCount.max,
                          min: _categoryQuestionCount.min,
                          divisions: _categoryQuestionCount.max.toInt() -
                              _categoryQuestionCount.min.toInt(),
                          label:
                              _categoryQuestionCount.amount.toStringAsFixed(0),
                        ),
                      ),
                      Text(_categoryQuestionCount.max.toStringAsFixed(0))
                    ],
                  ),
                ],
              ),
              Align(
                alignment: Alignment.center,
                child: OutlineButton(
                  onPressed: () async {
                    var qs = await locator.get<Api>().getQuestions(
                          _categories.selected.id,
                          _difficulty.selected.value,
                          _type.selected.value,
                          _categoryQuestionCount.amount.toInt(),
                        );

                    Navigator.pushNamed(context, "/trivia",
                        arguments: TriviaArguments(questions: qs));
                  },
                  child: Text("Start"),
                ),
              )
            ]
          ],
        ),
      ),
    );
  }
}

class OptionsSelector extends StatefulWidget {
  final BaseOptions _options;
  final String _label;
  final String _hint;

  OptionsSelector(this._options, this._label, this._hint);

  @override
  _OptionsSelectorState createState() => _OptionsSelectorState();
}

class _OptionsSelectorState extends State<OptionsSelector> {
  @override
  Widget build(BuildContext context) {
    var _categoryQuestionCount = Provider.of<CategoryQuestionCount>(context);

    return Column(
      children: <Widget>[
        Text(widget._label),
        DropdownButton<ApiOption>(
          hint: Text(widget._hint),
          value: widget._options.selected,
          isExpanded: true,
          onChanged: (val) {
            setState(() {
              widget._options.selected = val;
            });
            _categoryQuestionCount
                .setMinMaxAndAmount(widget._options.selected.value);
          },
          items: widget._options.options
              .map(
                (o) => DropdownMenuItem<ApiOption>(
                      value: o,
                      child: Text(o.text),
                    ),
              )
              .toList(),
        ),
        SizedBox(height: 28)
      ],
    );
  }
}
