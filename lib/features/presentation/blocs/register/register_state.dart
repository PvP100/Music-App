part of 'register_bloc.dart';

class RegisterState extends BaseState<RegisterState> {
  final DateTime? birthday;

  RegisterState({super.isLoading, super.error, this.birthday});

  @override
  RegisterState copyWith({
    bool isLoading = false,
    Failure? error,
    DateTime? birthday,
  }) {
    return RegisterState(
      isLoading: isLoading,
      error: error,
      birthday: birthday ?? this.birthday,
    );
  }
}
