import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:music_app/features/presentation/blocs/splash/splash_bloc.dart';
import 'package:music_app/features/presentation/ui/screen/base_screen.dart';
import '../../../../../core/core.dart';

class SplashScreen
    extends BaseScreenWithSingleTickerProvider<SplashBloc, SplashState> {
  SplashScreen({super.arguments});

  late AnimationController _animationController;

  @override
  void initState(SplashBloc screenBloc) {
    super.initState(screenBloc);
    _animationController =
        AnimationController(vsync: singleTickerProviderStateMixin);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget buildChild() {
    return Center(
      child: Lottie.asset(
        AppConstants.hello,
        frameRate: FrameRate(60),
        controller: _animationController,
        onLoaded: (composition) {
          _animationController
            ..duration = composition.duration
            ..forward().then((value) =>
                Navigator.pushReplacementNamed(context, RouteConstants.home));
        },
      ),
    );
  }
}
