import 'package:flutter/material.dart';
import 'package:flutter_trivia/pages/trivia.dart';
import 'package:flutter_trivia/services/api.dart';
import 'models/api_options.dart';

void main() {
  runApp(MyApp());
  print(ApiDifficulty().options[0].value);
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
      routes: {'/': (context) => HomePage(), '/trivia': (context) => Trivia()},
      initialRoute: '/',
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ApiCategory _category = ApiCategory();
  final ApiDifficulty _difficulty = ApiDifficulty();
  final TriviaType _type = TriviaType();
  double _amount = 6;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            OptionsSelector(_category, "Category", "Select a Category"),
            OptionsSelector(_difficulty, "Difficulty", "Select a Difficulty"),
            OptionsSelector(_type, "Type", "Select a Type"),
            SliderTheme(
              data: SliderThemeData(
                activeTickMarkColor: Colors.blue,
                disabledThumbColor: Colors.white
              ),
              child: Slider(
                onChanged: _amount == 5 ? null : (value) {
                  setState(() {
                    _amount = value;
                  });
                  print(value);
                },
                value: _amount,
                max: 10,
                min: 5,
                divisions: 10 - 5,
                label: _amount.toStringAsFixed(0),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: OutlineButton(
                onPressed: () async {
                  Api().getQuestions(_category.selected.value,
                      _difficulty.selected.value, _type.selected.value);

                  Navigator.pushNamed(context, "/trivia");
                },
                child: Text("Start"),
              ),
            )
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
