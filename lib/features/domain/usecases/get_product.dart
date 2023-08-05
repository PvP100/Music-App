import 'package:music_app/features/data/base/result.dart';
import 'package:music_app/features/data/models/image_model/image_model.dart';
import 'package:music_app/features/domain/repositories/image_repository.dart';
import 'package:music_app/features/domain/usecases/use_case.dart';

class GetRandomImage extends UseCase<ImageModel, None> {
  final ImageRepository _imageRepository;

  GetRandomImage(this._imageRepository);

  @override
  Future<Result<ImageModel>> run(None params) =>
      _imageRepository.getRandomImage();
}
