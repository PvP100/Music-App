import 'package:music_app/core/constants/api_path_constants.dart';
import 'package:music_app/features/data/base/base_dio.dart';
import 'package:music_app/features/data/base/result.dart';
import 'package:music_app/features/data/models/image_model/image_model.dart';
import 'package:music_app/features/data/models/login/login_model.dart';
import 'package:music_app/features/domain/entities/request/login_request.dart';

abstract class HaMusicApiProvider {
  Future<Result<ImageModel>> getRandomImage();
  Future<Result<LoginModel>> login(LoginRequest request);
}

class HaMusicApiProviderImpl implements HaMusicApiProvider {
  final IBaseDio _baseDio;

  HaMusicApiProviderImpl(this._baseDio);

  @override
  Future<Result<ImageModel>> getRandomImage() => _baseDio.request(
        'photos/random',
        fromJson: ImageModel.fromJson,
      );

  @override
  Future<Result<LoginModel>> login(LoginRequest request) => _baseDio.request(
        ApiPathConstants.login,
        fromJson: LoginModel.fromJson,
        method: ApiMethod.post,
        queryParameters: request.toMap(),
      );
}
