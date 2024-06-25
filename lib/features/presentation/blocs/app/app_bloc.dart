import 'package:flutter_bloc/flutter_bloc.dart';
part 'app_state.dart';

class AppBloc extends Cubit<AppState> {
  AppBloc() : super(AppState());

  playMusic(String id) {
    emit(state.copyWith(
        playState: PlayState(
      isPlay: true,
      songId: id,
      showMiniPlayer: true,
    )));
  }

  pauseMusic() {
    emit(state.copyWith(playState: PlayState(isPlay: false)));
  }
}
