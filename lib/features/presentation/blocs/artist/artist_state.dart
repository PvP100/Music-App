part of 'artist_bloc.dart';

class ArtistState extends BaseState<ArtistState> {
  const ArtistState({
    super.isLoading,
    super.error,
    this.model,
    this.isLiked = false,
  });

  final SingerModel? model;

  final bool isLiked;

  @override
  ArtistState copyWith({
    bool isLoading = false,
    Failure? error,
    SingerModel? model,
    bool? isLiked,
  }) =>
      ArtistState(
        isLoading: isLoading,
        error: error,
        model: model ?? this.model,
        isLiked: isLiked ?? this.isLiked,
      );
}
