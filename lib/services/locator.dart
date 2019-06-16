import 'package:flutter_trivia/services/api.dart';
import 'package:get_it/get_it.dart';

GetIt locator = new GetIt();

void setupLocator() {
  locator.registerLazySingleton<Api>(() => Api());
}
