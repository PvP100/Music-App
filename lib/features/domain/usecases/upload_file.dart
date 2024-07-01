import 'package:dio/dio.dart';
import 'package:music_app/features/data/base/base_response.dart';
import 'package:music_app/features/data/base/result.dart';
import 'package:music_app/features/data/models/models.dart';
import 'package:music_app/features/domain/repositories/hamusic_repository.dart';
import 'package:music_app/features/domain/usecases/use_case.dart';

class UploadFile
    extends UseCase<BaseObjectResponse<UploadModel>, MultipartFile> {
  final HamusicRepository _repository;

  UploadFile(this._repository);

  @override
  Future<Result<BaseObjectResponse<UploadModel>>> run(MultipartFile params) =>
      _repository.upload(params);
}
