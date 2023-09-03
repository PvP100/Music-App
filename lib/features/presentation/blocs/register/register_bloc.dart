import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/core/core.dart';
import 'package:music_app/features/data/exception/failure.dart';
import 'package:music_app/features/presentation/blocs/base/base_bloc.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends BaseBloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterState());

  @override
  void init() {
    on<OnBirthdaySelectedEvent>((event, emit) => emit(state.copyWith(
          birthday: event.birthday,
        )));
    on<OnRegisterEvent>(_register);
  }

  _register(OnRegisterEvent event, Emitter<RegisterState> emitter) {
    if (event.username.isEmpty) {
      return emitter(
          state.copyWith(error: localizations.usernameEmpty.toFailure()));
    }

    if (event.password.isEmpty) {
      return emitter(
          state.copyWith(error: localizations.passwordEmpty.toFailure()));
    }

    if (event.rePassword.isEmpty) {
      return emitter(
          state.copyWith(error: localizations.rePasswordEmpty.toFailure()));
    }

    if (event.fullName.isEmpty) {
      return emitter(
          state.copyWith(error: localizations.fullNameEmpty.toFailure()));
    }

    if (state.birthday == null) {
      return emitter(state.copyWith(
          error: localizations.dateOfBirthCannotBeEmpty.toFailure()));
    }

    if (!event.username.isEmail() && !event.username.isPhoneNumber()) {
      return emitter(
          state.copyWith(error: localizations.usernameIncorrect.toFailure()));
    }

    if (event.password != event.rePassword) {
      return emitter(
          state.copyWith(error: localizations.passwordNotMatch.toFailure()));
    }
  }
}
