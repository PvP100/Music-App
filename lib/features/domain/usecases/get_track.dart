import 'package:music_app/features/data/base/result.dart';
import 'package:music_app/features/data/models/list_track/list_track_model.dart';
import 'package:music_app/features/domain/repositories/hamusic_repository.dart';
import 'package:music_app/features/domain/usecases/use_case.dart';

class GetTrack extends UseCase<ListTrackModel, String> {
  final HamusicRepository _hamusicRepository;

  GetTrack(this._hamusicRepository);

  @override
  Future<Result<ListTrackModel>> run(String params) =>
      _hamusicRepository.getTrack(params);
}
