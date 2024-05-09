import 'package:music_app/features/data/base/result.dart';
import 'package:music_app/features/data/models/login/login_model.dart';
import 'package:music_app/features/domain/entities/request/login_request.dart';

abstract class HamusicRepository {
  Future<Result<LoginModel>> login(LoginRequest request);
}
