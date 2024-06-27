import 'package:music_app/features/data/base/result.dart';
import 'package:music_app/features/data/models/models.dart';
import 'package:music_app/features/domain/entities/request/login_request.dart';
import 'package:music_app/features/domain/entities/request/register_request.dart';

import '../../data/base/base_response.dart';
import '../../data/models/track/track_model.dart';

abstract class HamusicRepository {
  Future<Result<BaseObjectResponse<LoginModel>>> login(LoginRequest request);

  Future<Result<CategoriesModel>> getCategories();

  Future<Result<BaseListResponse<TrackModel>>> getTrack(String keyword);

  Future<Result<BaseObjectResponse<Profile>>> getProfile();

  Future<Result<BaseListResponse<HomeMenuModel>>> getHomeMenu();

  Future<Result<BaseObjectResponse<AlbumModel>>> getAlbum(String id);

  Future<Result<BaseListResponse<AlbumModel>>> getListAlbum(String keyword);

  Future<Result<BaseObjectResponse<AlbumModel>>> getPlaylist(String id);

  Future<Result<BaseListResponse<AlbumModel>>> getListPlaylist(String keyword);

  Future<Result<BaseListResponse<SingerModel>>> getListArtist(String keyword);

  Future<Result<BaseObjectResponse<SingerModel>>> getArtist(String id);

  Future<Result<BaseObjectResponse<SearchAllModel>>> searchAll(String keyword);

  Future<Result<bool>> logout(String refreshToken);

  Future<Result<bool>> register(RegisterRequest request);
}
