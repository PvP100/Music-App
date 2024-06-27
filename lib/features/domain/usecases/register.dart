import 'package:music_app/features/data/base/result.dart';
import 'package:music_app/features/domain/entities/request/register_request.dart';
import 'package:music_app/features/domain/repositories/hamusic_repository.dart';
import 'package:music_app/features/domain/usecases/use_case.dart';

class Register extends UseCase<bool, RegisterRequest> {
  final HamusicRepository _repository;

  Register(this._repository);

  @override
  Future<Result<bool>> run(RegisterRequest params) =>
      _repository.register(params);
}
