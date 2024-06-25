import 'dart:convert';

import 'package:music_app/core/constants/api_path_constants.dart';
import 'package:music_app/features/data/base/base_dio.dart';
import 'package:music_app/features/data/base/base_response.dart';
import 'package:music_app/features/data/base/result.dart';
import 'package:music_app/features/data/models/image_model/image_model.dart';
import 'package:music_app/features/data/models/track/track_model.dart';
import 'package:music_app/features/domain/entities/request/login_request.dart';

import '../../models/models.dart';

abstract class HaMusicApiProvider {
  Future<Result<ImageModel>> getRandomImage();
  Future<Result<BaseObjectResponse<LoginModel>>> login(LoginRequest request);
  Future<Result<CategoriesModel>> getCategories();
  Future<Result<BaseListResponse<TrackModel>>> getTrack();
  Future<Result<BaseObjectResponse<Profile>>> getProfile();
  Future<Result<BaseListResponse<HomeMenuModel>>> getHome();
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
  Future<Result<BaseObjectResponse<LoginModel>>> login(LoginRequest request) =>
      _baseDio.request(
        ApiPathConstants.login,
        fromJson: (json) => BaseObjectResponse.fromJson(json, LoginModel()),
        method: ApiMethod.post,
        part: jsonEncode(request.toMap()),
      );

  @override
  Future<Result<CategoriesModel>> getCategories() => _baseDio
      .request(ApiPathConstants.categories, fromJson: CategoriesModel.fromJson);

  @override
  Future<Result<BaseListResponse<TrackModel>>> getTrack() => _baseDio.request(
        ApiPathConstants.tracks,
        queryParameters: {
          "fields[]": "*,singers.*,singers.Singer_id.*",
        },
        fromJson: (json) => BaseListResponse.fromJson(json, TrackModel()),
      );

  @override
  Future<Result<BaseObjectResponse<Profile>>> getProfile() =>
      _baseDio.request(ApiPathConstants.profile,
          fromJson: (json) => BaseObjectResponse.fromJson(json, Profile()));

  @override
  Future<Result<BaseListResponse<HomeMenuModel>>> getHome() => _baseDio.request(
        ApiPathConstants.home,
        queryParameters: {
          'fields[]': [
            '*',
            'songs.Song_id.*',
            'songs.Song_id.singers.Singer_id.*',
            'albums.Album_id.*',
            'playlists.Playlist_id.*',
            'albums.Album_id.singers.Singer_id.*',
          ],
        },
        fromJson: (json) => BaseListResponse.fromJson(json, HomeMenuModel()),
      );
}
