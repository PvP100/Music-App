import 'package:music_app/features/data/base/result.dart';
import 'package:music_app/features/domain/entities/search_entity.dart';
import 'package:music_app/features/domain/repositories/hamusic_repository.dart';
import 'package:music_app/features/domain/usecases/use_case.dart';

import '../entities/request/like_request.dart';

class LikeHaMusic extends UseCase<bool, LikeRequest> {
  final HamusicRepository _repository;

  LikeHaMusic(this._repository);
  @override
  Future<Result<bool>> run(LikeRequest params) => switch (params.type) {
        TrackType.album => _repository.likeAlbum(params.id, params.userId),
        TrackType.song => _repository.likeSong(params.id, params.userId),
        TrackType.playlist =>
          _repository.likePlaylist(params.id, params.userId),
        _ => _repository.likeArtist(params.id, params.userId)
      };
}
