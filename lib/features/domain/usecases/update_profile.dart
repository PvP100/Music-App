import 'package:music_app/features/data/base/base_response.dart';
import 'package:music_app/features/data/base/result.dart';
import 'package:music_app/features/data/models/profile/profile_model.dart';
import 'package:music_app/features/domain/repositories/hamusic_repository.dart';
import 'package:music_app/features/domain/usecases/use_case.dart';

class UpdateProfile
    extends UseCase<BaseObjectResponse<Profile>, Map<String, dynamic>> {
  final HamusicRepository _repository;

  UpdateProfile(this._repository);

  @override
  Future<Result<BaseObjectResponse<Profile>>> run(
          Map<String, dynamic> params) =>
      _repository.updateProfile(params);
}
