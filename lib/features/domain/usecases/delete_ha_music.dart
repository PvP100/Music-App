import 'package:music_app/features/data/base/result.dart';
import 'package:music_app/features/domain/entities/request/delete_like_request.dart';
import 'package:music_app/features/domain/entities/search_entity.dart';
import 'package:music_app/features/domain/repositories/hamusic_repository.dart';
import 'package:music_app/features/domain/usecases/use_case.dart';

class DeleteHaMusic extends UseCase<bool, DeleteLikeRequest> {
  final HamusicRepository _repository;

  DeleteHaMusic(this._repository);

  @override
  Future<Result<bool>> run(DeleteLikeRequest params) => switch (params.type) {
        TrackType.album => _repository.unlikeAlbum(params.id),
        TrackType.playlist => _repository.unlikePlaylist(params.id),
        TrackType.song => _repository.unlikeSong(params.id),
        _ => _repository.unlikeArtist(params.id),
      };
}
