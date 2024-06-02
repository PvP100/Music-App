import 'package:music_app/core/core.dart';
import 'package:music_app/features/data/exception/failure.dart';
import 'package:music_app/features/presentation/blocs/base/base_bloc.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends BaseBloc<RegisterState> {
  RegisterBloc() : super(RegisterState());

  selectBirthday(DateTime birthday) {
    emit(state.copyWith(birthday: birthday));
  }

  register({
    required String username,
    required String password,
    required String rePassword,
    required String fullName,
  }) {
    if (username.isEmpty) {
      return emit(
          state.copyWith(error: localizations.usernameEmpty.toFailure()));
    }

    if (password.isEmpty) {
      return emit(
          state.copyWith(error: localizations.passwordEmpty.toFailure()));
    }

    if (rePassword.isEmpty) {
      return emit(
          state.copyWith(error: localizations.rePasswordEmpty.toFailure()));
    }

    if (fullName.isEmpty) {
      return emit(
          state.copyWith(error: localizations.fullNameEmpty.toFailure()));
    }

    if (state.birthday == null) {
      return emit(state.copyWith(
          error: localizations.dateOfBirthCannotBeEmpty.toFailure()));
    }

    if (!username.isEmail() && !username.isPhoneNumber()) {
      return emit(
          state.copyWith(error: localizations.usernameIncorrect.toFailure()));
    }

    if (password != rePassword) {
      return emit(
          state.copyWith(error: localizations.passwordNotMatch.toFailure()));
    }
  }
}
