import 'package:music_app/features/data/base/result.dart';

import 'package:music_app/features/data/models/image_model/image_model.dart';
import 'package:music_app/features/data/remote/api/image_api_provider.dart';

import '../../domain/repositories/image_repository.dart';

class ImageRepositoryImpl implements ImageRepository {
  final ImageApiProvider _imageApiProvider;

  ImageRepositoryImpl(this._imageApiProvider);

  @override
  Future<Result<ImageModel>> getRandomImage() =>
      _imageApiProvider.getRandomImage();
}
