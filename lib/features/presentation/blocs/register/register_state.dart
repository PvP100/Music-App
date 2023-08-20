part of 'register_bloc.dart';

class RegisterState extends BaseState {
  final DateTime? birthday;

  RegisterState({super.isLoading, super.errorMsg, this.birthday});

  @override
  RegisterState copyWith(
      {bool isLoading = false, String? errorMsg, DateTime? birthday}) {
    return RegisterState(
      isLoading: isLoading,
      errorMsg: errorMsg,
      birthday: birthday ?? this.birthday,
    );
  }
}
