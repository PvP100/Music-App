part of 'main_bloc.dart';

class MainState extends BaseState<MainState> {
  final TabNavigation currentScreen;

  MainState({
    super.isLoading,
    super.error,
    this.currentScreen = TabNavigation.home,
  });

  @override
  MainState copyWith({
    bool isLoading = false,
    Failure? error,
    TabNavigation? currentScreen,
  }) {
    return MainState(
      isLoading: isLoading,
      error: error,
      currentScreen: currentScreen ?? this.currentScreen,
    );
  }
}
