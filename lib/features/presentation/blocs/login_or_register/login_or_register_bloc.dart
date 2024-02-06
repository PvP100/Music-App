import 'package:music_app/features/presentation/blocs/base/base_bloc.dart';

part 'login_or_register_event.dart';
part 'login_or_register_state.dart';

class LoginOrRegisterBloc extends BaseBloc<LoginOrRegisterState> {
  LoginOrRegisterBloc() : super(LoginOrRegisterState());
}
