import 'package:music_app/features/data/base/base_response.dart';
import 'package:music_app/features/data/base/result.dart';
import 'package:music_app/features/data/remote/api/ha_music_api_provider.dart';
import 'package:music_app/features/domain/entities/request/login_request.dart';
import 'package:music_app/features/domain/entities/request/register_request.dart';

import '../../domain/repositories/hamusic_repository.dart';
import '../models/models.dart';
import '../models/track/track_model.dart';

class HaMusicRepositoryImpl implements HamusicRepository {
  final HaMusicApiProvider _haMusicApiProvider;

  HaMusicRepositoryImpl(this._haMusicApiProvider);

  @override
  Future<Result<BaseObjectResponse<LoginModel>>> login(LoginRequest request) =>
      _haMusicApiProvider.login(request);

  @override
  Future<Result<CategoriesModel>> getCategories() =>
      _haMusicApiProvider.getCategories();

  @override
  Future<Result<BaseListResponse<TrackModel>>> getTrack(String keyword) =>
      _haMusicApiProvider.getTrack(keyword);

  @override
  Future<Result<BaseObjectResponse<Profile>>> getProfile() =>
      _haMusicApiProvider.getProfile();

  @override
  Future<Result<BaseListResponse<HomeMenuModel>>> getHomeMenu() =>
      _haMusicApiProvider.getHome();

  @override
  Future<Result<BaseObjectResponse<AlbumModel>>> getAlbum(String id) =>
      _haMusicApiProvider.getAlbum(id);

  @override
  Future<Result<BaseObjectResponse<AlbumModel>>> getPlaylist(String id) =>
      _haMusicApiProvider.getPlaylist(id);

  @override
  Future<Result<BaseObjectResponse<SearchAllModel>>> searchAll(
          String keyword) =>
      _haMusicApiProvider.searchAll(keyword);

  @override
  Future<Result<BaseListResponse<AlbumModel>>> getListAlbum(String keyword) =>
      _haMusicApiProvider.getListAlbum(keyword);

  @override
  Future<Result<BaseListResponse<AlbumModel>>> getListPlaylist(
          String keyword) =>
      _haMusicApiProvider.getListPlaylist(keyword);

  @override
  Future<Result<BaseListResponse<SingerModel>>> getListArtist(String keyword) =>
      _haMusicApiProvider.getListArtist(keyword);

  @override
  Future<Result<BaseObjectResponse<SingerModel>>> getArtist(String id) =>
      _haMusicApiProvider.getArtist(id);

  @override
  Future<Result<bool>> logout(String refreshToken) =>
      _haMusicApiProvider.logout(refreshToken);

  @override
  Future<Result<bool>> register(RegisterRequest request) =>
      _haMusicApiProvider.register(request);
}
