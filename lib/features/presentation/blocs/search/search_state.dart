part of 'search_bloc.dart';

class SearchState extends BaseState<SearchState> {
  SearchState({super.isLoading, super.error});

  @override
  SearchState copyWith({bool isLoading = false, Failure? error}) {
    return SearchState(isLoading: isLoading, error: error);
  }
}
