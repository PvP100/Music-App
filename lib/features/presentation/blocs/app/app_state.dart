part of 'app_bloc.dart';

class AppState {
  final PlayState? playState;

  AppState({this.playState, this.isUpdateProfile = false, this.isLiked});

  final bool isUpdateProfile;

  final bool? isLiked;

  AppState copyWith({
    PlayState? playState,
    bool isUpdateProfile = false,
    bool? isLiked,
  }) =>
      AppState(
        playState: playState ?? this.playState,
        isUpdateProfile: isUpdateProfile,
        isLiked: isLiked ?? this.isLiked,
      );
}

class PlayState {
  final bool isPlay;

  final bool showMiniPlayer;

  final String? songId;

  final List<String>? songs;

  PlayState({
    this.isPlay = false,
    this.showMiniPlayer = false,
    this.songId,
    this.songs,
  });

  PlayState copyWith({
    bool? isPlay,
    bool? showMiniPlayer,
    String? songId,
    List<String>? songs,
    bool? isLiked,
  }) =>
      PlayState(
        isPlay: isPlay ?? this.isPlay,
        showMiniPlayer: showMiniPlayer ?? this.showMiniPlayer,
        songId: songId ?? this.songId,
        songs: songs ?? this.songs,
      );
}
