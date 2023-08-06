import 'package:flutter/material.dart';

extension BuildContextExtension on BuildContext {
  void pop<T extends Object?>({bool rootNavigator = false, T? result}) {
    Navigator.of(this, rootNavigator: rootNavigator).pop(result);
  }

  double get width => MediaQuery.sizeOf(this).width;

  double get height => MediaQuery.sizeOf(this).height;
}
