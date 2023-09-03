part of 'home_bloc.dart';

class HomeState extends BaseState<HomeState> {
  final String? imageUrl;

  const HomeState({super.isLoading, super.error, this.imageUrl});

  @override
  HomeState copyWith(
      {bool isLoading = false, Failure? error, String? imageUrl}) {
    return HomeState(
      isLoading: isLoading,
      error: error,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
