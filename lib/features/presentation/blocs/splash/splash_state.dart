part of 'splash_bloc.dart';

class SplashState extends BaseState<SplashState> {
  final bool isNavigateToHome;

  const SplashState(
      {super.isLoading, super.error, this.isNavigateToHome = false});

  @override
  SplashState copyWith({
    bool isLoading = false,
    Failure? error,
    bool isNavigateToHome = false,
  }) =>
      SplashState(
        isLoading: isLoading,
        error: error,
        isNavigateToHome: isNavigateToHome,
      );
}
