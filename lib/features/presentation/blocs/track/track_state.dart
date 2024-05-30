part of 'track_bloc.dart';

class TrackState extends BaseState<TrackState> {
  TrackState({
    super.isLoading,
    super.error,
    this.track,
    this.currentIndex,
  });

  final ObjectListEntity<TrackModel>? track;

  final int? currentIndex;

  @override
  TrackState copyWith({
    bool isLoading = false,
    Failure? error,
    ObjectListEntity<TrackModel>? track,
    int? currentIndex,
  }) =>
      TrackState(
        isLoading: isLoading,
        error: error,
        track: track ?? this.track,
        currentIndex: currentIndex ?? this.currentIndex,
      );
}
