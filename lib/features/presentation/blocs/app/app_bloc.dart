import 'package:flutter_bloc/flutter_bloc.dart';
part 'app_state.dart';

class AppBloc extends Cubit<AppState> {
  AppBloc() : super(AppState());

  playMusic(String id, [List<String>? songIds]) {
    emit(state.copyWith(
        playState: PlayState(
      isPlay: true,
      songId: id,
      showMiniPlayer: true,
      songs: songIds,
    )));
  }

  updateProfile() {
    emit(state.copyWith(isUpdateProfile: true));
  }

  favorite() {
    emit(state.copyWith(isLiked: true));
  }

  pauseMusic() {
    emit(state.copyWith(playState: PlayState(isPlay: false)));
  }
}
