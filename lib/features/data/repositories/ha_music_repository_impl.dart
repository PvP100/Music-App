import 'package:music_app/features/data/base/base_response.dart';
import 'package:music_app/features/data/base/result.dart';
import 'package:music_app/features/data/models/category/category_model.dart';
import 'package:music_app/features/data/models/list_track/list_track_model.dart';
import 'package:music_app/features/data/models/login/login_model.dart';

import 'package:music_app/features/data/remote/api/ha_music_api_provider.dart';
import 'package:music_app/features/domain/entities/request/login_request.dart';

import '../../domain/repositories/hamusic_repository.dart';

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
  Future<Result<ListTrackModel>> getTrack(String trackId) =>
      _haMusicApiProvider.getTrack(trackId);
}
