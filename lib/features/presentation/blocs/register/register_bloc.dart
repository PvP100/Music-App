import 'package:music_app/core/core.dart';
import 'package:music_app/features/data/exception/failure.dart';
import 'package:music_app/features/domain/entities/request/register_request.dart';
import 'package:music_app/features/domain/usecases/domain_use_cases.dart';
import 'package:music_app/features/presentation/blocs/base/base_bloc.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends BaseBloc<RegisterState> {
  final Register _registerUseCase;

  RegisterBloc(this._registerUseCase) : super(RegisterState());

  selectBirthday(DateTime birthday) {
    emit(state.copyWith(birthday: birthday));
  }

  register({
    required String username,
    required String password,
    required String rePassword,
    required String firstName,
    required String lastName,
  }) async {
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

    if (firstName.isEmpty) {
      return emit(
          state.copyWith(error: localizations.firstNameEmpty.toFailure()));
    }

    if (lastName.isEmpty) {
      return emit(
          state.copyWith(error: localizations.lastNameEmpty.toFailure()));
    }

    // if (state.birthday == null) {
    //   return emit(state.copyWith(
    //       error: localizations.dateOfBirthCannotBeEmpty.toFailure()));
    // }

    if (!username.isEmail() && !username.isPhoneNumber()) {
      return emit(
          state.copyWith(error: localizations.usernameIncorrect.toFailure()));
    }

    if (password != rePassword) {
      return emit(
          state.copyWith(error: localizations.passwordNotMatch.toFailure()));
    }

    emitLoading();

    final useCase = await _registerUseCase(RegisterRequest(
      email: username,
      password: password,
      firstName: firstName,
      lastName: lastName,
      // birthday: state.birthday?.convertToString().convertDateTime() ?? "",
    ));

    useCase.fold(
        (data) => emit(state.copyWith(isRegisterSuccess: true)), emitError);
  }
}
