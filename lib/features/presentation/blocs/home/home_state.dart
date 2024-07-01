part of 'home_bloc.dart';

class HomeState extends BaseState<HomeState> {
  final String? imageUrl;

  final List<HomeMenuEntity>? entities;

  final Profile? profile;

  const HomeState({
    super.isLoading,
    super.error,
    this.imageUrl,
    this.entities,
    this.profile,
  });

  @override
  HomeState copyWith({
    bool isLoading = false,
    Failure? error,
    String? imageUrl,
    List<HomeMenuEntity>? entities,
    Profile? profile,
  }) {
    return HomeState(
      isLoading: isLoading,
      error: error,
      imageUrl: imageUrl ?? this.imageUrl,
      entities: entities ?? this.entities,
      profile: profile ?? this.profile,
    );
  }
}
