import 'package:music_app/features/data/base/result.dart';
import 'package:music_app/features/data/models/list_track/list_track_model.dart';
import 'package:music_app/features/data/models/models.dart';
import 'package:music_app/features/domain/entities/request/login_request.dart';

import '../../data/base/base_response.dart';

abstract class HamusicRepository {
  Future<Result<BaseObjectResponse<LoginModel>>> login(LoginRequest request);

  Future<Result<CategoriesModel>> getCategories();

  Future<Result<ListTrackModel>> getTrack(String trackId);
}
