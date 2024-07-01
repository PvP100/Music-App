part of 'library_bloc.dart';

class LibraryState extends BaseState<LibraryState> {
  LibraryState({
    super.isLoading,
    super.error,
    this.profile,
    this.entities,
    this.type,
  });

  final Profile? profile;

  final List<SearchEntity>? entities;

  final SearchType? type;

  @override
  LibraryState copyWith({
    bool isLoading = false,
    Failure? error,
    Profile? profile,
    List<SearchEntity>? entities,
    SearchType? type,
  }) {
    return LibraryState(
      isLoading: isLoading,
      error: error,
      profile: profile ?? this.profile,
      entities: entities ?? this.entities,
      type: type ?? this.type,
    );
  }
}
