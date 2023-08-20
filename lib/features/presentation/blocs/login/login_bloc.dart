import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/core/core.dart';
import 'package:music_app/features/presentation/blocs/base/base_bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends BaseBloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState());

  @override
  void init() {
    on<OnLoginEvent>(_login);
  }

  _login(OnLoginEvent event, Emitter<LoginState> emitter) async {
    if (event.password.isEmpty || event.username.isEmpty) {
      return emitter(
        state.copyWith(errorMsg: localizations.usernameAndPasswordError),
      );
    }
    if (!event.username.isEmail() && !event.username.isPhoneNumber()) {
      return emitter(state.copyWith(errorMsg: localizations.usernameIncorrect));
    }
    if (event.password.length < AppConstants.passwordLengthValidate) {
      return emitter(
          state.copyWith(errorMsg: localizations.passwordLengthError));
    }

    emitter(state.copyWith(isLoading: true));
    await Future.delayed(2.seconds);
    emitter(state.copyWith(isLoginSuccess: true));
  }
}
