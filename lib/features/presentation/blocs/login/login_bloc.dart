import 'package:music_app/core/constants/shared_preferences_constants.dart';
import 'package:music_app/core/core.dart';
import 'package:music_app/features/data/preference/ha_music_shared_preference.dart';
import 'package:music_app/features/domain/entities/request/login_request.dart';
import 'package:music_app/features/domain/usecases/login_use_case.dart';
import 'package:music_app/features/presentation/blocs/base/base_bloc.dart';

import '../../../data/exception/failure.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends BaseBloc<LoginState> {
  final LoginUseCase _loginUseCase;
  final HaMusicSharedPreference _mPrefs;

  LoginBloc(this._loginUseCase, this._mPrefs) : super(LoginState());

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
    emitLoading();
    final useCase = await _loginUseCase(LoginRequest(
      email: username,
      password: password,
    ));
    useCase.fold((data) async {
      await _mPrefs.put(
          SharedPreferencesConstants.appToken, data?.data?.accessToken);
      emit(state.copyWith(isLoginSuccess: true));
    }, emitError);
  }
}
