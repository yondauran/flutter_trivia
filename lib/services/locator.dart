import 'dart:convert';

import 'package:flutter_trivia/services/api.dart';
import 'package:get_it/get_it.dart';
import 'package:html_unescape/html_unescape_small.dart';

GetIt locator = new GetIt();

void setupLocator() {
  locator.registerLazySingleton<Api>(() => Api());
  locator.registerLazySingleton<HtmlUnescape>(() => HtmlUnescape());
  locator.registerLazySingleton<AsciiCodec>(() => AsciiCodec());
}
