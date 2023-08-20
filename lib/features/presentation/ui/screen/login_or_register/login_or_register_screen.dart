import 'dart:math';

import 'package:flutter/material.dart';
import 'package:music_app/config/app_routes.dart';
import 'package:music_app/core/core.dart';
import 'package:music_app/features/presentation/blocs/blocs.dart';
import 'package:music_app/features/presentation/ui/common_widgets/widgets.dart';
import 'package:music_app/features/presentation/ui/screen/base_screen_state.dart';
import '../../../../../core/constants/image_constants.dart';

class LoginOrRegisterScreen extends StatefulWidget {
  const LoginOrRegisterScreen({super.key});

  @override
  State<LoginOrRegisterScreen> createState() => _LoginOrRegisterScreenState();
}

class _LoginOrRegisterScreenState extends BaseScreenState<
    LoginOrRegisterScreen,
    LoginOrRegisterBloc,
    LoginOrRegisterState> with SingleTickerProviderStateMixin {
  late final AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget buildContent(BuildContext context) => AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          return controller.value <= 0.5
              ? Transform(
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.0025)
                    ..rotateY(controller.value * pi),
                  alignment: FractionalOffset.center,
                  child: child)
              : const SizedBox();
        },
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ImageConstants.iconLogo
                  .loadImageAsset(height: 85, fit: BoxFit.fitHeight)
                  .paddingOnly(bottom: 50),
              CommonButton(
                title: localizations.register,
                margin: const EdgeInsets.symmetric(horizontal: 47),
                backgroundColor: Colors.white,
                titleColor: Colors.black,
                onClick: () {
                  context.pushNamed(
                    RouteConstants.register,
                    transitionType: TransitionType.flip,
                  );
                },
              ),
              CommonButton(
                title: localizations.login,
                margin: const EdgeInsets.fromLTRB(47, 22, 47, 0),
                onClick: () {
                  context.pushNamed(
                    RouteConstants.login,
                    transitionType: TransitionType.flip,
                  );
                },
              )
            ],
          ),
        ),
      );

  @override
  void didPushNext() {
    controller.forward();
    super.didPushNext();
  }

  @override
  void didPopNext() {
    controller.reverse();
    super.didPopNext();
  }
}
