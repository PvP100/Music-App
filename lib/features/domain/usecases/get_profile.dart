import 'package:music_app/features/data/base/base_response.dart';
import 'package:music_app/features/data/base/result.dart';
import 'package:music_app/features/data/models/models.dart';
import 'package:music_app/features/domain/repositories/hamusic_repository.dart';
import 'package:music_app/features/domain/usecases/use_case.dart';

class GetProfile extends UseCase<BaseObjectResponse<Profile>, None> {
  final HamusicRepository _repository;

  GetProfile(this._repository);

  @override
  Future<Result<BaseObjectResponse<Profile>>> run(None params) =>
      _repository.getProfile();
}
