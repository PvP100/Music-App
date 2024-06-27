import 'package:music_app/features/data/base/result.dart';
import 'package:music_app/features/domain/repositories/hamusic_repository.dart';
import 'package:music_app/features/domain/usecases/use_case.dart';

class Logout extends UseCase<bool, String> {
  final HamusicRepository _repository;

  Logout(this._repository);

  @override
  Future<Result<bool>> run(String params) => _repository.logout(params);
}
