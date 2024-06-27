import 'package:music_app/features/data/base/base_response.dart';
import 'package:music_app/features/data/base/result.dart';
import 'package:music_app/features/data/models/singer/singer_model.dart';
import 'package:music_app/features/domain/repositories/hamusic_repository.dart';
import 'package:music_app/features/domain/usecases/use_case.dart';

class GetArtist extends UseCase<BaseObjectResponse<SingerModel>, String> {
  final HamusicRepository _repository;

  GetArtist(this._repository);

  @override
  Future<Result<BaseObjectResponse<SingerModel>>> run(String params) =>
      _repository.getArtist(params);
}
