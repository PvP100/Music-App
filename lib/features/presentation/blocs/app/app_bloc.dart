import 'package:flutter_bloc/flutter_bloc.dart';
part 'app_state.dart';

class AppBloc extends Cubit<AppState> {
  AppBloc() : super(AppState());

  playMusic() {
    emit(state.copyWith(
        playState: PlayState(isPlay: true, showMiniPlayer: true)));
  }

  pauseMusic() {
    emit(state.copyWith(playState: PlayState(isPlay: false)));
  }
}
