import 'package:music_app/features/data/base/base_response.dart';
import 'package:music_app/features/data/exception/failure.dart';
import 'package:music_app/features/domain/usecases/get_artist.dart';
import 'package:music_app/features/presentation/blocs/base/base_bloc.dart';

import '../../../data/models/models.dart';

part 'artist_state.dart';

class ArtistBloc extends BaseBloc<ArtistState> {
  final GetArtist _getArtistUseCase;
  ArtistBloc(this._getArtistUseCase) : super(const ArtistState());

  getArtist(String id) async {
    emitLoading();
    final useCase = await _getArtistUseCase(id);
    useCase.fold(_emitData, emitError);
  }

  _emitData(BaseObjectResponse<SingerModel>? model) {
    emit(state.copyWith(model: model?.data));
  }
}
