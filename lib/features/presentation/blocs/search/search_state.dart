part of 'search_bloc.dart';

class SearchState extends BaseState {
  SearchState({super.isLoading, super.errorMsg});

  @override
  SearchState copyWith({bool isLoading = false, String? errorMsg}) {
    return SearchState(isLoading: isLoading, errorMsg: errorMsg);
  }
}
