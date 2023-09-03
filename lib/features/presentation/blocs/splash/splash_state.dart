part of 'splash_bloc.dart';

class SplashState extends BaseState {
  final bool isNavigateToHome;

  const SplashState(
      {super.isLoading, super.errorMsg, this.isNavigateToHome = false});

  @override
  SplashState copyWith({
    bool isLoading = false,
    Exception? errorMsg,
    bool isNavigateToHome = false,
  }) =>
      SplashState(
        isLoading: isLoading,
        errorMsg: errorMsg,
        isNavigateToHome: isNavigateToHome,
      );
}
