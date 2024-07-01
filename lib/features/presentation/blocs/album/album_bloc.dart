import 'package:collection/collection.dart';
import 'package:music_app/features/domain/entities/album_playlist_entity.dart';
import 'package:music_app/features/domain/entities/request/album_playlist_request.dart';
import 'package:music_app/features/domain/entities/request/like_request.dart';
import 'package:music_app/features/domain/entities/search_entity.dart';
import 'package:music_app/features/domain/usecases/domain_use_cases.dart';
import 'package:music_app/features/domain/usecases/use_case.dart';
import 'package:music_app/features/presentation/blocs/base/base_bloc.dart';

import '../../../data/exception/failure.dart';
import '../../../domain/entities/request/delete_like_request.dart';

part 'album_state.dart';

class AlbumBloc extends BaseBloc<AlbumState> {
  final GetAlbumPlaylist _getAlbumPlaylistUseCase;

  final LikeHaMusic _likeUseCase;

  final GetProfile _getProfileUseCase;

  final DeleteHaMusic _unlikeUseCase;

  AlbumBloc(
    this._getAlbumPlaylistUseCase,
    this._likeUseCase,
    this._getProfileUseCase,
    this._unlikeUseCase,
  ) : super(const AlbumState());

  bool album = false;

  String userId = "";

  getData(String id, bool isAlbum) async {
    album = isAlbum;
    emitLoading();
    final profileUseCase = await _getProfileUseCase(None());
    final profile = profileUseCase.data?.data;
    final isLiked = isAlbum
        ? (profile?.album?.any((element) => element.data?.id == id) ?? false)
        : (profile?.playlist?.any((element) => element.data?.id == id) ??
            false);
    userId = profile?.id ?? "";
    final useCase = await _getAlbumPlaylistUseCase(
        AlbumPlaylistRequest(isAlbum: album, id: id));
    useCase.fold((data) => emitData(data, isLiked), emitError);
  }

  favorite() {
    if (state.isLiked) {
      _unlike();
    } else {
      _like();
    }
  }

  _like() async {
    emitLoading();
    final useCase = await _likeUseCase(LikeRequest(
      id: state.entity?.id ?? "",
      userId: userId,
      type: album ? TrackType.album : TrackType.playlist,
    ));
    useCase.fold((data) => emitData(null, true), emitError);
  }

  _unlike() async {
    emitLoading();
    final profile = (await _getProfileUseCase(None())).data?.data;
    late int id;
    if (album) {
      id = (profile?.album ?? [])
              .firstWhereOrNull(
                  (element) => element.data?.id == state.entity?.id)
              ?.id ??
          0;
    } else {
      id = (profile?.playlist ?? [])
              .firstWhereOrNull(
                  (element) => element.data?.id == state.entity?.id)
              ?.id ??
          0;
    }

    final useCase = await _unlikeUseCase(DeleteLikeRequest(
        id: id, type: album ? TrackType.album : TrackType.playlist));
    useCase.fold((data) => emitData(null, false), emitError);
  }

  emitData(AlbumPlaylistEntity? entity, bool isLiked) {
    emit(state.copyWith(
      entity: entity,
      isLiked: isLiked,
    ));
  }
}
