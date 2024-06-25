part of 'app_bloc.dart';

class AppState {
  final PlayState? playState;

  AppState({this.playState});

  AppState copyWith({PlayState? playState}) =>
      AppState(playState: playState ?? this.playState);
}

class PlayState {
  final bool isPlay;

  final bool showMiniPlayer;

  final String? songId;

  PlayState({
    this.isPlay = false,
    this.showMiniPlayer = false,
    this.songId,
  });

  PlayState copyWith({bool? isPlay, bool? showMiniPlayer, String? songId}) =>
      PlayState(
        isPlay: isPlay ?? this.isPlay,
        showMiniPlayer: showMiniPlayer ?? this.showMiniPlayer,
        songId: songId ?? this.songId,
      );
}
