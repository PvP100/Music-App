part of 'main_bloc.dart';

class MainState extends BaseState<MainState> {
  final TabNavigation currentScreen;

  final TrackState? trackState;

  MainState({
    super.isLoading,
    super.error,
    this.currentScreen = TabNavigation.home,
    this.trackState,
  });

  @override
  MainState copyWith({
    bool isLoading = false,
    Failure? error,
    TabNavigation? currentScreen,
    TrackState? trackState,
  }) {
    return MainState(
      isLoading: isLoading,
      error: error,
      currentScreen: currentScreen ?? this.currentScreen,
      trackState: trackState ?? this.trackState,
    );
  }
}

class TrackState {
  final int? currentIndex;

  final ObjectListEntity<TrackModel>? track;

  final bool isRefresh;

  TrackState({this.currentIndex, this.track, this.isRefresh = false});

  TrackState copyWith({
    ObjectListEntity<TrackModel>? track,
    int? currentIndex,
    bool isRefresh = false,
  }) =>
      TrackState(
        track: track ?? this.track,
        isRefresh: isRefresh,
        currentIndex: currentIndex ?? this.currentIndex,
      );
}
