import 'package:music_app/features/presentation/blocs/base/base_bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends BaseBloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState());
}
