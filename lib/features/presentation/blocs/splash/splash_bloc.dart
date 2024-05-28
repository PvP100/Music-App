import 'package:music_app/features/data/exception/failure.dart';
import 'package:music_app/features/presentation/blocs/base/base_bloc.dart';

import '../../../data/preference/ha_music_shared_preference.dart';
part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends BaseBloc<SplashState> {
  final HaMusicSharedPreference preferences;

  SplashBloc(this.preferences) : super(const SplashState());
}
