part of 'album_bloc.dart';

class AlbumState extends BaseState<AlbumState> {
  final AlbumPlaylistEntity? entity;

  final bool isLiked;

  const AlbumState({
    super.error,
    super.isLoading,
    this.entity,
    this.isLiked = false,
  });

  @override
  AlbumState copyWith({
    bool isLoading = false,
    Failure? error,
    AlbumPlaylistEntity? entity,
    bool? isLiked,
  }) =>
      AlbumState(
        isLoading: isLoading,
        error: error,
        entity: entity ?? this.entity,
        isLiked: isLiked ?? this.isLiked,
      );
}
