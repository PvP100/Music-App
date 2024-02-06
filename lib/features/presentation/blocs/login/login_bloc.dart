import 'package:music_app/core/core.dart';
import 'package:music_app/features/presentation/blocs/base/base_bloc.dart';

import '../../../data/exception/failure.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends BaseBloc<LoginState> {
  LoginBloc() : super(LoginState());

  login({required String password, required String username}) async {
    if (password.isEmpty || username.isEmpty) {
      return emit(
        state.copyWith(
            error: Failure.error(localizations.usernameAndPasswordError)),
      );
    }
    if (!username.isEmail() && !username.isPhoneNumber()) {
      return emit(
          state.copyWith(error: localizations.usernameIncorrect.toFailure()));
    }
    if (password.length < AppConstants.passwordLengthValidate) {
      return emit(
          state.copyWith(error: localizations.passwordLengthError.toFailure()));
    }

    emit(state.copyWith(isLoading: true));
    await Future.delayed(2.seconds);
    emit(state.copyWith(isLoginSuccess: true));
  }
}
