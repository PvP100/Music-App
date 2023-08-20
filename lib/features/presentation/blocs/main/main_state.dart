part of 'main_bloc.dart';

class MainState extends BaseState {
  final TabNavigation currentScreen;

  MainState({
    super.isLoading,
    super.errorMsg,
    this.currentScreen = TabNavigation.home,
  });

  @override
  MainState copyWith(
      {bool isLoading = false,
      String? errorMsg,
      TabNavigation? currentScreen}) {
    return MainState(
      isLoading: isLoading,
      errorMsg: errorMsg,
      currentScreen: currentScreen ?? this.currentScreen,
    );
  }
}
