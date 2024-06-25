import 'package:music_app/features/data/base/result.dart';
import 'package:music_app/features/data/models/models.dart';
import 'package:music_app/features/domain/entities/request/login_request.dart';

import '../../data/base/base_response.dart';
import '../../data/models/track/track_model.dart';

abstract class HamusicRepository {
  Future<Result<BaseObjectResponse<LoginModel>>> login(LoginRequest request);

  Future<Result<CategoriesModel>> getCategories();

  Future<Result<BaseListResponse<TrackModel>>> getTrack();

  Future<Result<BaseObjectResponse<Profile>>> getProfile();

  Future<Result<BaseListResponse<HomeMenuModel>>> getHomeMenu();
}
