import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../features/presentation/ui/screen/base/base_screen.dart';

class AppRoutes {
  static PageRoute getRoute(RouteSettings settings) {
    late final Widget widget;
    try {
      BaseScreen screen = GetIt.I.get<BaseScreen>(
        instanceName: settings.name,
        param1: settings.arguments,
      );
      widget = screen.buildParent();
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
