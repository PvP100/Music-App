import 'package:music_app/features/domain/entities/album_playlist_entity.dart';
import 'package:music_app/features/domain/entities/request/album_playlist_request.dart';
import 'package:music_app/features/domain/usecases/get_album.dart';
import 'package:music_app/features/presentation/blocs/base/base_bloc.dart';

import '../../../data/exception/failure.dart';

part 'album_state.dart';

class AlbumBloc extends BaseBloc<AlbumState> {
  final GetAlbumPlaylist _getAlbumPlaylistUseCase;

  AlbumBloc(this._getAlbumPlaylistUseCase) : super(const AlbumState());

  getData(String id, bool isAlbum) async {
    emitLoading();
    final useCase = await _getAlbumPlaylistUseCase(
        AlbumPlaylistRequest(isAlbum: isAlbum, id: id));
    useCase.fold(emitData, emitError);
  }

  emitData(AlbumPlaylistEntity? entity) {
    emit(state.copyWith(entity: entity));
  }
}
