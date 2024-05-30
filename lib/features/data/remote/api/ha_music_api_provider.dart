import 'package:music_app/core/constants/api_path_constants.dart';
import 'package:music_app/features/data/base/base_dio.dart';
import 'package:music_app/features/data/base/result.dart';
import 'package:music_app/features/data/models/image_model/image_model.dart';
import 'package:music_app/features/data/models/list_track/list_track_model.dart';
import 'package:music_app/features/domain/entities/request/login_request.dart';

import '../../models/models.dart';

abstract class HaMusicApiProvider {
  Future<Result<ImageModel>> getRandomImage();
  Future<Result<LoginModel>> login(LoginRequest request);
  Future<Result<CategoriesModel>> getCategories();
  Future<Result<ListTrackModel>> getTrack(String trackId);
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

  @override
  Future<Result<CategoriesModel>> getCategories() => _baseDio
      .request(ApiPathConstants.categories, fromJson: CategoriesModel.fromJson);

  @override
  Future<Result<ListTrackModel>> getTrack(String trackId) =>
      _baseDio.request(ApiPathConstants.tracks,
          queryParameters: {"ids": trackId}, fromJson: ListTrackModel.fromJson);
}
