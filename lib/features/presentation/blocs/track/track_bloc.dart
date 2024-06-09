import 'package:music_app/features/data/exception/failure.dart';
import 'package:music_app/features/data/models/track/track_model.dart';
import 'package:music_app/features/domain/entities/object_list_entity.dart';
import 'package:music_app/features/domain/usecases/get_track.dart';
import 'package:music_app/features/presentation/blocs/base/base_bloc.dart';

part 'track_state.dart';

class TrackBloc extends BaseBloc<TrackState> {
  final GetTrack _getTrackUseCase;

  TrackBloc(this._getTrackUseCase) : super(TrackState());

  final List<String> ids = [
    "5U30iZBlmxkpHqzb1OSnBS",
    "6bXmKNVe9YIjoyDbz04nWg",
    "014DA3BdnmD3kI5pBogH7c",
    "0RiRZpuVRbi7oqRdSMwhQY",
  ];

  @override
  void init() {
    getTrack(ids.join(","));
  }

  void getTrack(String trackId) async {
    emitLoading();
    final useCase = await _getTrackUseCase(trackId);
    useCase.fold((data) {
      emit(state.copyWith(
        track: ObjectListEntity(data?.tracks ?? []),
        currentIndex: 0,
        isRefresh: true,
      ));
    }, emitError);
  }

  void changeTrack(int index) {
    emit(state.copyWith(currentIndex: index));
  }
}
