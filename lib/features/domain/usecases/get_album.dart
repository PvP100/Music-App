import 'package:music_app/features/data/base/result.dart';
import 'package:music_app/features/domain/entities/request/album_playlist_request.dart';
import 'package:music_app/features/domain/repositories/hamusic_repository.dart';
import 'package:music_app/features/domain/usecases/use_case.dart';

import '../entities/album_playlist_entity.dart';

class GetAlbumPlaylist
    extends UseCase<AlbumPlaylistEntity, AlbumPlaylistRequest> {
  final HamusicRepository _repository;

  GetAlbumPlaylist(this._repository);

  @override
  Future<Result<AlbumPlaylistEntity>> run(AlbumPlaylistRequest params) async {
    Result<AlbumPlaylistEntity> useCase;
    if (params.isAlbum) {
      final api = await _repository.getAlbum(params.id);
      useCase = api.convert((data) => AlbumPlaylistEntity(
            id: data?.data?.id,
            name: data?.data?.name,
            thumbnail: data?.data?.thumbnail,
            songs: data?.data?.songs,
          ));
    } else {
      final api = await _repository.getPlaylist(params.id);
      useCase = api.convert((data) => AlbumPlaylistEntity(
            id: data?.data?.id,
            name: data?.data?.name,
            thumbnail: data?.data?.thumbnail,
            songs: data?.data?.songs,
          ));
    }
    return useCase;
  }
}
