import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class AppRoutes {
  static PageRoute getRoute(RouteSettings settings) {
    Widget widget;
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
    return CupertinoPageRoute(builder: (context) => widget, settings: settings);
    // return PageRouteBuilder(
    //     settings: settings,
    //     pageBuilder: (BuildContext context, Animation<double> animation,
    //         Animation<double> secondaryAnimation) {
    //       return widget;
    //     },
    //     transitionsBuilder: (
    //       BuildContext context,
    //       Animation<double> animation,
    //       Animation<double> secondaryAnimation,
    //       Widget child,
    //     ) {
    //       return SlideTransition(
    //         position: Tween(
    //           begin: const Offset(1, 0),
    //           end: Offset.zero,
    //         ).animate(animation),
    //         child: SlideTransition(
    //           position: Tween(
    //             begin: Offset.zero,
    //             end: const Offset(-1, 0),
    //           ).animate(secondaryAnimation),
    //           child: child,
    //         ),
    //       );
    //     });
  }
}
