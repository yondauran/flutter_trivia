import 'package:flutter/material.dart';
import 'package:flutter_trivia/models/categories.dart';
import 'package:flutter_trivia/models/category_question_count.dart';
import 'package:flutter_trivia/pages/trivia.dart';
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
          scaffoldBackgroundColor: Colors.blueGrey[900],
          brightness: Brightness.dark),
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
        '/trivia': (context) => Trivia()
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
    var _categoryQuestionCount = Provider.of<CategoryQuestionCount>(context);
    var _categories = Provider.of<Categories>(context);

    getCategories() async {
      if (_categories.triviaCategories == null) {
        var res = await _categories.getCategories();
        print("asdf" + res.toString());
        _categoryQuestionCount.getQuestionCount(_categories.selected.id);
        _categoryQuestionCount.setMinMaxAndAmount(_difficulty.selected.value);
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
          children: <Widget>[
            if (_categories.triviaCategories == null) ...[
              CircularProgressIndicator(),
            ] else ...[
              Column(
                children: <Widget>[
                  Text("Category"),
                  SizedBox(
                    height: 56,
                    child: DropdownButton<TriviaCategory>(
                      hint: Text("Select a Category"),
                      value: _categories.selected,
                      isExpanded: true,
                      onChanged: (val) {
                        _categories.selected = val;
                        _categoryQuestionCount.getQuestionCount(val.id);
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
              Slider(
                onChanged: (value) {
                  _categoryQuestionCount.amount = value;
                  print(_categoryQuestionCount.amount);
                },
                value: _categoryQuestionCount.amount,
                max: _categoryQuestionCount.min,
                min: _categoryQuestionCount.max,
                divisions: _categoryQuestionCount.max.toInt() -
                    _categoryQuestionCount.min.toInt(),
                label: _categoryQuestionCount.amount.toStringAsFixed(0),
              ),
              Align(
                alignment: Alignment.center,
                child: OutlineButton(
                  onPressed: () async {
                    locator.get<Api>().getQuestions(_categories.selected.id,
                        _difficulty.selected.value, _type.selected.value);

                    Navigator.pushNamed(context, "/trivia");
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
    return Column(
      children: <Widget>[
        Text(widget._label),
        DropdownButton<ApiOption>(
          hint: Text(widget._hint),
          value: widget._options.selected,
          onChanged: (val) {
            setState(() {
              widget._options.selected = val;
            });
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
