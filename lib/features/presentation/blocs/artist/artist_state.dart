part of 'artist_bloc.dart';

class ArtistState extends BaseState<ArtistState> {
  const ArtistState({super.isLoading, super.error, this.model});

  final SingerModel? model;

  @override
  ArtistState copyWith({
    bool isLoading = false,
    Failure? error,
    SingerModel? model,
  }) =>
      ArtistState(
        isLoading: isLoading,
        error: error,
        model: model ?? this.model,
      );
}
