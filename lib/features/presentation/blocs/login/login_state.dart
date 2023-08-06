part of 'login_bloc.dart';

class LoginState extends BaseState {
  LoginState({super.errorMsg, super.isLoading});

  @override
  LoginState copyWith({bool isLoading = false, String? errorMsg}) =>
      LoginState(isLoading: isLoading, errorMsg: errorMsg);
}
