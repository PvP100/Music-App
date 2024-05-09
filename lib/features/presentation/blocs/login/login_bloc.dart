import 'package:music_app/core/core.dart';
import 'package:music_app/features/domain/entities/request/login_request.dart';
import 'package:music_app/features/domain/usecases/login_use_case.dart';
import 'package:music_app/features/presentation/blocs/base/base_bloc.dart';

import '../../../data/exception/failure.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends BaseBloc<LoginState> {
  final LoginUseCase _loginUseCase;

  LoginBloc(this._loginUseCase) : super(LoginState());

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
    final useCase = await _loginUseCase(LoginRequest(
      grantType: "client_credentials",
      clientId: "816997b654de499faa6f277bcefdf196",
      clientSecret: "2a5f8e38511a4ee8b11503b3dfe7533d",
    ));
    useCase.fold((data) {
      emit(state.copyWith(isLoginSuccess: true));
    }, (e) => emit(state.copyWith(error: e)));
  }
}
