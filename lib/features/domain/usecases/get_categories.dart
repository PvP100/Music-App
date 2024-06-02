import 'package:music_app/features/data/base/result.dart';
import 'package:music_app/features/data/models/models.dart';
import 'package:music_app/features/domain/repositories/hamusic_repository.dart';
import 'package:music_app/features/domain/usecases/use_case.dart';

class GetCategories extends UseCase<CategoriesModel, None> {
  final HamusicRepository _repository;

  GetCategories(this._repository);

  @override
  Future<Result<CategoriesModel>> run(None params) =>
      _repository.getCategories();
}
