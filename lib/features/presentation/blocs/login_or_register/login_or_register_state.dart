part of 'login_or_register_bloc.dart';

class LoginOrRegisterState extends BaseState<LoginOrRegisterState> {
  @override
  LoginOrRegisterState copyWith({bool isLoading = false, Exception? error}) {
    return LoginOrRegisterState();
  }
}
