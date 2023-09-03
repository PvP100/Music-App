part of 'library_bloc.dart';

class LibraryState extends BaseState<LibraryState> {
  LibraryState({super.isLoading, super.error});

  @override
  LibraryState copyWith({bool isLoading = false, Failure? error}) {
    return LibraryState(isLoading: isLoading, error: error);
  }
}
