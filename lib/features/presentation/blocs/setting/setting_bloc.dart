import 'package:music_app/features/data/exception/failure.dart';
import 'package:music_app/features/presentation/blocs/base/base_bloc.dart';

part 'setting_state.dart';

class SettingBloc extends BaseBloc<SettingState> {
  SettingBloc() : super(const SettingState());

  logout() async {
    emit(state.copyWith(isLogout: true));
  }
}
