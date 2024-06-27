part of 'album_bloc.dart';

class AlbumState extends BaseState<AlbumState> {
  final AlbumPlaylistEntity? entity;

  const AlbumState({super.error, super.isLoading, this.entity});

  @override
  AlbumState copyWith({
    bool isLoading = false,
    Failure? error,
    AlbumPlaylistEntity? entity,
  }) =>
      AlbumState(
        isLoading: isLoading,
        error: error,
        entity: entity ?? this.entity,
      );
}
