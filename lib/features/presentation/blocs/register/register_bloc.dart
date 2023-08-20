import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/core/core.dart';
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
      return emitter(state.copyWith(errorMsg: localizations.usernameEmpty));
    }

    if (event.password.isEmpty) {
      return emitter(state.copyWith(errorMsg: localizations.passwordEmpty));
    }

    if (event.rePassword.isEmpty) {
      return emitter(state.copyWith(errorMsg: localizations.rePasswordEmpty));
    }

    if (event.fullName.isEmpty) {
      return emitter(state.copyWith(errorMsg: localizations.fullNameEmpty));
    }

    if (state.birthday == null) {
      return emitter(
          state.copyWith(errorMsg: localizations.dateOfBirthCannotBeEmpty));
    }

    if (!event.username.isEmail() && !event.username.isPhoneNumber()) {
      return emitter(state.copyWith(errorMsg: localizations.usernameIncorrect));
    }

    if (event.password != event.rePassword) {
      return emitter(state.copyWith(errorMsg: localizations.passwordNotMatch));
    }
  }
}
