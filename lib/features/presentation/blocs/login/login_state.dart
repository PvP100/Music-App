part of 'login_bloc.dart';

class LoginState extends BaseState {
  final bool isLoginSuccess;

  LoginState({super.errorMsg, super.isLoading, this.isLoginSuccess = false});

  @override
  LoginState copyWith({
    bool isLoading = false,
    String? errorMsg,
    bool? canLogin,
    bool isLoginSuccess = false,
  }) =>
      LoginState(
        isLoading: isLoading,
        errorMsg: errorMsg,
        isLoginSuccess: isLoginSuccess,
      );
}
