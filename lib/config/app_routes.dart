import 'dart:io';

import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:music_app/core/core.dart';

class AppRoutes {
  static PageRoute getRoute(RouteSettings settings) {
    late final Widget widget;
    TransitionType? transitionType;
    if (settings.arguments != null) {
      transitionType = (settings.arguments
          as Map<String, dynamic>)[ArgumentKey.transitionType];
    }
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
    switch (transitionType) {
      case TransitionType.flip:
        return PageRouteBuilder(
            settings: settings,
            pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation) {
              return widget;
            },
            transitionDuration: const Duration(milliseconds: 500),
            reverseTransitionDuration: const Duration(milliseconds: 500),
            transitionsBuilder: (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child,
            ) {
              return Transform(
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.0025)
                  ..rotateY(pi - animation.value * -pi),
                alignment: FractionalOffset.center,
                child: animation.value > 0.5 ? child : const SizedBox(),
              );
            });
      default:
        return Platform.isAndroid
            ? MaterialPageRoute(builder: (context) => widget, settings: settings)
            : CupertinoPageRoute(builder: (context) => widget, settings: settings);
    }
  }
}

enum TransitionType { ios, android, flip }
