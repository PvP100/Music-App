part of 'like_bloc.dart';

class LikeState extends BaseState<LikeState> {
  final ObjectListEntity<ChildSongHomeMenuModel>? songs;

  const LikeState({
    super.error,
    super.isLoading,
    this.songs,
  });
  @override
  LikeState copyWith({
    bool isLoading = false,
    Failure? error,
    ObjectListEntity<ChildSongHomeMenuModel>? songs,
  }) =>
      LikeState(
        isLoading: isLoading,
        error: error,
        songs: songs ?? this.songs,
      );
}
