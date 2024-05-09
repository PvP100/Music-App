import 'package:music_app/features/data/base/result.dart';
import 'package:music_app/features/data/models/login/login_model.dart';
import 'package:music_app/features/domain/entities/request/login_request.dart';
import 'package:music_app/features/domain/repositories/hamusic_repository.dart';
import 'package:music_app/features/domain/usecases/use_case.dart';

class LoginUseCase extends UseCase<LoginModel, LoginRequest> {
  final HamusicRepository _repository;

  LoginUseCase(this._repository);

  @override
  Future<Result<LoginModel>> run(LoginRequest params) =>
      _repository.login(params);
}
