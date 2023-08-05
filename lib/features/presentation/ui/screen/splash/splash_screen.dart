import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:music_app/features/presentation/blocs/splash/splash_bloc.dart';
import '../base_screen_state.dart';
import '../../../../../core/core.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState
    extends BaseScreenState<SplashScreen, SplashBloc, SplashState>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget get buildContent => Center(
        child: Lottie.asset(
          LottiePath.hello,
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

  @override
  void onStateListener(BuildContext context, SplashState state) {}

  @override
  Future<bool> willPopCallback() async {
    return false;
  }
}
