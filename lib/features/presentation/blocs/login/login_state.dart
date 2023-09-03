part of 'login_bloc.dart';

class LoginState extends BaseState<LoginState> {
  final bool isLoginSuccess;

  LoginState({super.error, super.isLoading, this.isLoginSuccess = false});

  @override
  LoginState copyWith({
    bool isLoading = false,
    Failure? error,
    bool? canLogin,
    bool isLoginSuccess = false,
  }) =>
      LoginState(
        isLoading: isLoading,
        error: error,
        isLoginSuccess: isLoginSuccess,
      );
}
