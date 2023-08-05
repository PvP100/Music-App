part of 'home_bloc.dart';

class HomeState extends BaseState<HomeState> {
  final String? imageUrl;

  HomeState({super.isLoading, super.errorMsg, this.imageUrl});

  @override
  HomeState copyWith(
      {bool isLoading = false, String? errorMsg, String? imageUrl}) {
    return HomeState(
      isLoading: isLoading,
      errorMsg: errorMsg,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
