import 'package:music_app/features/data/base/result.dart';
import 'package:music_app/features/domain/repositories/hamusic_repository.dart';
import 'package:music_app/features/domain/usecases/use_case.dart';

import '../../data/base/base_response.dart';
import '../../data/models/track/track_model.dart';

class GetTrack
    extends UseCase<BaseListResponse<TrackModel>, Map<String?, String>?> {
  final HamusicRepository _hamusicRepository;

  GetTrack(this._hamusicRepository);

  @override
  Future<Result<BaseListResponse<TrackModel>>> run(
      Map<String?, String>? params) async {
    final api = await _hamusicRepository.getTrack(params?.values.first ?? "");
    return api.convert((data) {
      final newList = data?.data;
      if ((newList ?? [])
          .any((element) => element.id == params?.keys.firstOrNull)) {
        final currentSong = newList
            ?.firstWhere((element) => element.id == params?.keys.firstOrNull);
        if (currentSong != null) {
          newList?.remove(currentSong);
          newList?.insert(0, currentSong);
        }
        return BaseListResponse(data: newList);
      }

      return data;
    });
  }
}
