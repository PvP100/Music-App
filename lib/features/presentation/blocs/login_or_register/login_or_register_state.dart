part of 'login_or_register_bloc.dart';

class LoginOrRegisterState extends BaseState {
  @override
  BaseState copyWith({bool isLoading = false, String? errorMsg}) {
    return LoginOrRegisterState();
  }
}
