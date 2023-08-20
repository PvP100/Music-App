part of 'library_bloc.dart';

class LibraryState extends BaseState {
  LibraryState({super.isLoading, super.errorMsg});

  @override
  LibraryState copyWith({bool isLoading = false, String? errorMsg}) {
    return LibraryState(isLoading: isLoading, errorMsg: errorMsg);
  }
}
