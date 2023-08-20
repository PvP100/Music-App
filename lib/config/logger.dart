import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

final logi = Logger(
    printer:
        PrettyPrinter(methodCount: 0, printEmojis: false, printTime: false));

void flutterDebugPrint(String value) {
  if (kDebugMode) {
    print(value);
  }
}
