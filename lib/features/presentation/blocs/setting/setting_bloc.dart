import 'package:music_app/core/constants/shared_preferences_constants.dart';
import 'package:music_app/features/data/exception/failure.dart';
import 'package:music_app/features/data/preference/ha_music_shared_preference.dart';
import 'package:music_app/features/domain/usecases/logout.dart';
import 'package:music_app/features/presentation/blocs/base/base_bloc.dart';

part 'setting_state.dart';

class SettingBloc extends BaseBloc<SettingState> {
  final Logout _logoutUseCase;

  final HaMusicSharedPreference _sharedPreference;

  SettingBloc(
    this._logoutUseCase,
    this._sharedPreference,
  ) : super(const SettingState());

  logout() async {
    emitLoading();
    final refreshToken = _sharedPreference
        .get<String>(SharedPreferencesConstants.appRefreshToken);
    if (refreshToken != null) {
      final useCase = await _logoutUseCase(refreshToken);
      useCase.fold((data) async {
        await _sharedPreference
            .removeKey(SharedPreferencesConstants.appRefreshToken);
        await _sharedPreference.removeKey(SharedPreferencesConstants.appToken);
        emit(state.copyWith(isLogout: true));
      }, emitError);
    } else {
      emitError(Failure.error(
          "No Refresh Token. Please Remove app and install again."));
    }
  }
}
