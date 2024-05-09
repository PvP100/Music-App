import 'package:music_app/features/data/base/result.dart';
import 'package:music_app/features/data/models/login/login_model.dart';

import 'package:music_app/features/data/remote/api/image_api_provider.dart';
import 'package:music_app/features/domain/entities/request/login_request.dart';

import '../../domain/repositories/hamusic_repository.dart';

class HaMusicRepositoryImpl implements HamusicRepository {
  final HaMusicApiProvider _haMusicApiProvider;

  HaMusicRepositoryImpl(this._haMusicApiProvider);

  @override
  Future<Result<LoginModel>> login(LoginRequest request) =>
      _haMusicApiProvider.login(request);
}
