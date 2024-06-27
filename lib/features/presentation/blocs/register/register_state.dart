part of 'register_bloc.dart';

class RegisterState extends BaseState<RegisterState> {
  final DateTime? birthday;

  final bool isRegisterSuccess;

  RegisterState({
    super.isLoading,
    super.error,
    this.birthday,
    this.isRegisterSuccess = false,
  });

  @override
  RegisterState copyWith({
    bool isLoading = false,
    Failure? error,
    DateTime? birthday,
    bool isRegisterSuccess = false,
  }) {
    return RegisterState(
      isLoading: isLoading,
      error: error,
      birthday: birthday ?? this.birthday,
      isRegisterSuccess: isRegisterSuccess,
    );
  }
}
