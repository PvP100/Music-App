import 'package:flutter/material.dart';

extension NumExtension on num {
  Duration get milliseconds => Duration(milliseconds: toInt());

  Duration get seconds => Duration(seconds: toInt());

  Duration get microseconds => Duration(microseconds: toInt());

  Duration get hours => Duration(hours: toInt());

  Radius get radius => Radius.circular(toDouble());

  String convertToMinuteAndSecond() {
    int totalSecond = this ~/ 1000;
    int minute = totalSecond ~/ 60;
    int second = totalSecond % 60;
    return "$minute:${second.toString().padLeft(2, "0")}";
  }
}
