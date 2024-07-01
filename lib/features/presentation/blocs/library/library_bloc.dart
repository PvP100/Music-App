import 'package:music_app/features/domain/entities/enum/search_type.dart';
import 'package:music_app/features/domain/entities/search_entity.dart';
import 'package:music_app/features/domain/usecases/domain_use_cases.dart';
import 'package:music_app/features/presentation/blocs/base/base_bloc.dart';

import '../../../data/base/base_response.dart';
import '../../../data/exception/failure.dart';
import '../../../data/models/models.dart';
import '../../../domain/usecases/use_case.dart';

part 'library_event.dart';
part 'library_state.dart';

class LibraryBloc extends BaseBloc<LibraryState> {
  final GetProfile _getProfileUseCase;

  LibraryBloc(this._getProfileUseCase) : super(LibraryState());

  @override
  void init() {
    getProfile(true);
  }

  getProfile([isShowLoading = false]) async {
    if (isShowLoading) {
      emitLoading();
    }
    final useCase = await _getProfileUseCase(None());
    useCase.fold(_emitDataProfile, emitError);
  }

  _emitDataProfile(BaseObjectResponse<Profile>? p) {
    emit(state.copyWith(profile: p?.data));
    changePage((state.type?.index ?? 2) - 2);
  }

  changePage(index) {
    final type = SearchType.values[index + 2];
    List<SearchEntity> entites = switch (type) {
      SearchType.artist => (state.profile?.artist ?? [])
          .map((e) => SearchEntity(
                type: TrackType.artist,
                name: e.data?.name,
                image: e.data?.thumbnail,
                id: e.data?.id,
              ))
          .toList(),
      SearchType.album => (state.profile?.album ?? [])
          .map((e) => SearchEntity(
                type: TrackType.album,
                name: e.data?.name,
                image: e.data?.thumbnail,
                id: e.data?.id,
                artist: e.data?.singers
                    ?.map((e) => e.data?.name)
                    .toList()
                    .join(", "),
              ))
          .toList(),
      SearchType.playlist => (state.profile?.playlist ?? [])
          .map((e) => SearchEntity(
              type: TrackType.playlist,
              name: e.data?.name,
              image: e.data?.thumbnail,
              id: e.data?.id,
              artist: e.data?.singers
                  ?.map((e) => e.data?.name)
                  .toList()
                  .join(", ")))
          .toList(),
      _ => []
    };
    emit(state.copyWith(entities: entites, type: type));
  }
}
