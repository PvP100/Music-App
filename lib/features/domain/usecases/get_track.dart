import 'package:collection/collection.dart';
import 'package:music_app/features/data/base/result.dart';
import 'package:music_app/features/domain/repositories/hamusic_repository.dart';
import 'package:music_app/features/domain/usecases/use_case.dart';

import '../../data/base/base_response.dart';
import '../../data/models/track/track_model.dart';

class GetTrack
    extends UseCase<BaseListResponse<TrackModel>, Map<String?, dynamic>?> {
  final HamusicRepository _hamusicRepository;

  GetTrack(this._hamusicRepository);

  @override
  Future<Result<BaseListResponse<TrackModel>>> run(
      Map<String?, dynamic>? params) async {
    final api = await _hamusicRepository.getTrack(params?.values.first ?? "");
    final apiProfile = await _hamusicRepository.getProfile();
    final songLikedIds =
        (apiProfile.data?.data?.songs ?? []).map((e) => e.data?.id ?? "");
    return api.convert((data) {
      final newList = <TrackModel>[];
      if (params?.containsKey("songIds") == true) {
        final songIds = params?["songIds"] as List<String>?;
        for (var songId in songIds ?? []) {
          final song = (data?.data ?? [])
              .firstWhereOrNull((element) => element.id == songId);
          if (song != null) {
            newList.add(song);
          }
        }
      } else {
        newList.addAll(data?.data ?? []);
      }
      if ((newList).any((element) => element.id == params?.keys.firstOrNull)) {
        final currentSong = newList.firstWhereOrNull(
            (element) => element.id == params?.keys.firstOrNull);
        if (currentSong != null) {
          newList.remove(currentSong);
          newList.insert(0, currentSong);
        }
        for (var id in songLikedIds) {
          newList.firstWhereOrNull((element) => element.id == id)?.isLiked =
              true;
        }
        return BaseListResponse(data: newList);
      }

      return data;
    });
  }
}
