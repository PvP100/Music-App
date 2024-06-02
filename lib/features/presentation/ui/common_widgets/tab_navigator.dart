import 'package:flutter/cupertino.dart';
import '../../../../config/config.dart';

class TabNavigator extends StatelessWidget {
  const TabNavigator(
      {super.key, this.navigatorKey, required this.initialRoute});

  final GlobalKey<NavigatorState>? navigatorKey;
  final String initialRoute;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      initialRoute: initialRoute,
      onGenerateRoute: AppRoutes.getRoute,
    );
  }
}
