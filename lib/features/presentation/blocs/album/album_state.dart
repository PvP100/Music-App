part of 'album_bloc.dart';

class AlbumState extends BaseState<AlbumState> {
  const AlbumState({super.error, super.isLoading});

  @override
  AlbumState copyWith({bool isLoading = false, Failure? error}) => AlbumState(
        isLoading: isLoading,
        error: error,
      );
}
