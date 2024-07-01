import 'package:collection/collection.dart';
import 'package:music_app/features/data/exception/failure.dart';
import 'package:music_app/features/domain/entities/request/delete_like_request.dart';
import 'package:music_app/features/domain/entities/request/like_request.dart';
import 'package:music_app/features/domain/entities/search_entity.dart';
import 'package:music_app/features/domain/usecases/use_case.dart';
import 'package:music_app/features/presentation/blocs/app/app_bloc.dart';
import 'package:music_app/features/presentation/blocs/base/base_bloc.dart';
import 'package:music_app/features/presentation/ui/screen/main/main_screen.dart';

import '../../../data/models/track/track_model.dart';
import '../../../domain/entities/object_list_entity.dart';
import '../../../domain/usecases/domain_use_cases.dart';

part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends BaseBloc<MainState> {
  final GetTrack _getTrackUseCase;

  final LikeHaMusic _likeHaMusic;

  final GetProfile _getProfileUseCase;

  final DeleteHaMusic _unlikeUseCase;

  final AppBloc _appBloc;

  MainBloc(
    this._getTrackUseCase,
    this._likeHaMusic,
    this._getProfileUseCase,
    this._appBloc,
    this._unlikeUseCase,
  ) : super(MainState());

  @override
  init() {}

  changScreen(TabNavigation tabNavigation) {
    emit(state.copyWith(
      currentScreen: tabNavigation,
      trackState: state.trackState?.copyWith(isRefresh: false),
    ));
  }

  void getTrack(String? trackId, [List<String>? songIds]) async {
    final params = <String?, dynamic>{trackId: ""};
    if (songIds != null && songIds.isNotEmpty) {
      params.addAll({"songIds": songIds});
    }
    final useCase = await _getTrackUseCase(params);
    useCase.fold((data) {
      emit(state.copyWith(
          trackState: TrackState(
        track: ObjectListEntity(data?.data ?? []),
        currentIndex: 0,
        isRefresh: true,
      )));
    }, emitError);
  }

  void favoriteSong() async {
    final currentIndex = state.trackState?.currentIndex ?? 0;
    final currentTrack = state.trackState?.track?.models[currentIndex];
    if (currentTrack != null) {
      if (currentTrack.isLiked) {
        await _unlike(currentTrack.id!);
      } else {
        await _like(currentTrack.id!);
      }
      _appBloc.favorite();
    }
  }

  _unlike(String id) async {
    emitLoading();
    final songs = (await _getProfileUseCase(None())).data?.data?.songs;
    final songId =
        songs?.firstWhereOrNull((element) => element.data?.id == id)?.id ?? 0;
    final unlikeUseCase = (await _unlikeUseCase(
      DeleteLikeRequest(id: songId, type: TrackType.song),
    ));
    unlikeUseCase.fold((data) {
      final list = state.trackState?.track?.models ?? [];
      list.firstWhereOrNull((element) => element.id == id)?.isLiked = false;
      emit(state.copyWith(
          trackState:
              state.trackState?.copyWith(track: ObjectListEntity(list))));
    }, emitError);
  }

  _like(String id) async {
    emitLoading();
    final userId = (await _getProfileUseCase(None())).data?.data?.id ?? "";
    final likeUseCase = await _likeHaMusic(LikeRequest(
      id: id,
      userId: userId,
      type: TrackType.song,
    ));
    likeUseCase.fold((data) {
      final list = state.trackState?.track?.models ?? [];
      list.firstWhereOrNull((element) => element.id == id)?.isLiked = true;
      emit(state.copyWith(
          trackState:
              state.trackState?.copyWith(track: ObjectListEntity(list))));
    }, emitError);
  }

  void changeTrack(int index) {
    emit(state.copyWith(
        trackState: state.trackState?.copyWith(currentIndex: index)));
  }
}
