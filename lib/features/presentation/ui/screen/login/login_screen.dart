import 'package:flutter/material.dart';
import 'package:music_app/core/constants/image_constants.dart';
import 'package:music_app/core/core.dart';
import 'package:music_app/features/presentation/blocs/blocs.dart';
import 'package:music_app/features/presentation/ui/common_widgets/widgets.dart';
import 'package:music_app/features/presentation/ui/custom/loading_indicator.dart';
import 'package:music_app/features/presentation/ui/screen/base_screen_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState
    extends BaseScreenState<LoginScreen, LoginBloc, LoginState>
    with SingleTickerProviderStateMixin {
  final Animatable<Offset> _kMiddleLeftTween = Tween<Offset>(
    begin: Offset.zero,
    end: const Offset(-1.0 / 3.0, 0.0),
  );

  late final AnimationController _controller;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    super.initState();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget buildContent(BuildContext context) {
    return SlideTransition(
      position: CurvedAnimation(
        parent: _controller,
        curve: Curves.linearToEaseOut,
        reverseCurve: Curves.easeInToLinear,
      ).drive(_kMiddleLeftTween),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        HaMusicAppBar(title: localizations.login),
        SingleChildScrollView(
          child: Column(children: [
            ImageConstants.iconLogo
                .loadImageAsset(height: 85, fit: BoxFit.fitHeight)
                .paddingOnly(
                  top: 40,
                  bottom: 60,
                ),
            CommonTextField(
              controller: _usernameController,
              margin: const EdgeInsets.symmetric(horizontal: 30),
              hintText: localizations.emailOrPhone,
            ),
            CommonTextField(
              controller: _passwordController,
              isPassword: true,
              margin: const EdgeInsets.fromLTRB(30, 23, 30, 12),
              hintText: localizations.password,
            ),
            Text(
              localizations.forgotPasswordWithQuestionMark,
              style: AppTextStyles.medium.copyWith(fontSize: 14),
            )
                .onCupertinoClick(() {
                  context.pushNamed(RouteConstants.forgotPassword);
                })
                .align(Alignment.centerRight)
                .paddingOnly(right: 30),
            CommonButton(
              title: localizations.login,
              margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              onClick: () {
                bloc.add(OnLoginEvent(
                  username: _usernameController.text.trim(),
                  password: _passwordController.text.trim(),
                ));
              },
            )
          ]),
        ).expanded()
      ]),
    );
  }

  @override
  Color get backgroundColor => AppColors.primaryBackgroundColor;

  @override
  bool get safeAreaBottom => false;

  @override
  void onStateListener(BuildContext context, LoginState state) {
    super.onStateListener(context, state);
    if (state.isLoginSuccess) {
      context.pushNamed(RouteConstants.main);
    }
  }

  @override
  void didPushNext() {
    if (!LoadingIndicator.isShowing) {
      _controller.forward();
    }
    super.didPushNext();
  }

  @override
  void didPopNext() {
    if (!LoadingIndicator.isShowing) {
      _controller.reverse();
    }
    super.didPopNext();
  }
}
