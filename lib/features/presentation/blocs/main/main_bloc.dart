import 'package:music_app/features/data/exception/failure.dart';
import 'package:music_app/features/presentation/blocs/base/base_bloc.dart';
import 'package:music_app/features/presentation/ui/screen/main/main_screen.dart';

import '../../../data/models/track/track_model.dart';
import '../../../domain/entities/object_list_entity.dart';
import '../../../domain/usecases/domain_use_cases.dart';

part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends BaseBloc<MainState> {
  final GetTrack _getTrackUseCase;

  final List<String> ids = [
    "5U30iZBlmxkpHqzb1OSnBS",
    "6bXmKNVe9YIjoyDbz04nWg",
    "014DA3BdnmD3kI5pBogH7c",
    "0RiRZpuVRbi7oqRdSMwhQY",
  ];

  MainBloc(this._getTrackUseCase) : super(MainState());

  changScreen(TabNavigation tabNavigation) {
    emit(state.copyWith(
      currentScreen: tabNavigation,
      trackState: state.trackState?.copyWith(isRefresh: false),
    ));
  }

  void getTrack(String? trackId) async {
    final useCase = await _getTrackUseCase({trackId: ""});
    useCase.fold((data) {
      emit(state.copyWith(
          trackState: TrackState(
        track: ObjectListEntity(data?.data ?? []),
        currentIndex: 0,
        isRefresh: true,
      )));
    }, emitError);
  }

  void changeTrack(int index) {
    emit(state.copyWith(
        trackState: state.trackState?.copyWith(currentIndex: index)));
  }
}
