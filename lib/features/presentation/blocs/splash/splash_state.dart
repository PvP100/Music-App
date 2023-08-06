part of 'splash_bloc.dart';

class SplashState extends BaseState {
  final bool isNavigateToHome;

  SplashState({super.isLoading, super.errorMsg, this.isNavigateToHome = false});

  @override
  SplashState copyWith({
    bool isLoading = false,
    String? errorMsg,
    bool isNavigateToHome = false,
  }) =>
      SplashState(
        isLoading: isLoading,
        errorMsg: errorMsg,
        isNavigateToHome: isNavigateToHome,
      );
}
