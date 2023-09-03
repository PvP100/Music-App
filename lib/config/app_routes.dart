import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class AppRoutes {
  static PageRoute getRoute(RouteSettings settings) {
    late final Widget widget;
    try {
      widget = GetIt.I.get<Widget>(instanceName: settings.name);
    } catch (e) {
      widget = Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Không tìm thấy trang'),
        ),
        body: const Center(child: Text('Page not found')),
      );
    }
    return Platform.isAndroid
        ? MaterialPageRoute(builder: (context) => widget, settings: settings)
        : CupertinoPageRoute(builder: (context) => widget, settings: settings);
  }
}
