part of 'setting_bloc.dart';

class SettingState extends BaseState<SettingState> {
  const SettingState({super.isLoading, super.error, this.isLogout = false});

  final bool isLogout;

  @override
  SettingState copyWith(
          {bool isLoading = false, Failure? error, bool isLogout = false}) =>
      SettingState(
        isLoading: isLoading,
        error: error,
        isLogout: isLogout,
      );
}
