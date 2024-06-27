part of 'search_bloc.dart';

class SearchState extends BaseState<SearchState> {
  final ObjectListEntity<SearchEntity>? data;

  SearchState({super.isLoading, super.error, this.data});

  @override
  SearchState copyWith({
    bool isLoading = false,
    Failure? error,
    ObjectListEntity<SearchEntity>? data,
  }) {
    return SearchState(
      isLoading: isLoading,
      error: error,
      data: data ?? this.data,
    );
  }
}
