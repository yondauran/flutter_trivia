# Flutter Trivia

Cross-platform mobile application made with Flutter. It's a Trivia app made using the OpenTDB API
(Trivia Database, which contains questions based on different topics and answers (both multiple-choice
and true-false). It's still a WIP.

The purpose of the application is purely educational. The application implements:
1. The new **provider** package demonstrated at Google I/O 2019 (State Management). I believe Flutter's state management is still immature and _provider_ is a step into the right direction; BLoC just wasn't for me
2. REST API Calls using **http** package (to the OpenTDB API)

## Todo
1. Remove the hard-coded API options and retrieve the options using the API (check OpenTDB's API Docs)
2. Implement an _amount_ slider based on the info retrieved from the options (see above). Some categories and difficulties have a max amount of questions
3. After the previous 2, implement missing functionality: trivia start, choice picking, question change, trivia end page with results, restart
