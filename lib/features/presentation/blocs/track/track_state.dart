part of 'track_bloc.dart';

class TrackState extends BaseState<TrackState> {
  TrackState({
    super.isLoading,
    super.error,
    this.track,
    this.currentIndex,
    this.isRefresh = false,
  });

  final ObjectListEntity<TrackModel>? track;

  final bool isRefresh;

  final int? currentIndex;

  @override
  TrackState copyWith({
    bool isLoading = false,
    Failure? error,
    ObjectListEntity<TrackModel>? track,
    int? currentIndex,
    bool isRefresh = false,
  }) =>
      TrackState(
        isLoading: isLoading,
        error: error,
        track: track ?? this.track,
        isRefresh: isRefresh,
        currentIndex: currentIndex ?? this.currentIndex,
      );
}
