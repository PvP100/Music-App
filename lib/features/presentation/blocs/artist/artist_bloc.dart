import 'package:collection/collection.dart';
import 'package:music_app/features/data/base/base_response.dart';
import 'package:music_app/features/data/exception/failure.dart';
import 'package:music_app/features/domain/entities/request/delete_like_request.dart';
import 'package:music_app/features/domain/entities/request/like_request.dart';
import 'package:music_app/features/domain/entities/search_entity.dart';
import 'package:music_app/features/domain/usecases/domain_use_cases.dart';
import 'package:music_app/features/domain/usecases/use_case.dart';
import 'package:music_app/features/presentation/blocs/base/base_bloc.dart';

import '../../../data/models/models.dart';

part 'artist_state.dart';

class ArtistBloc extends BaseBloc<ArtistState> {
  final GetArtist _getArtistUseCase;
  final GetProfile _getProfileUseCase;
  final LikeHaMusic _likeUseCase;
  final DeleteHaMusic _unlikeUseCase;
  ArtistBloc(
    this._getArtistUseCase,
    this._getProfileUseCase,
    this._likeUseCase,
    this._unlikeUseCase,
  ) : super(const ArtistState());

  String? userId;

  getArtist(String id) async {
    emitLoading();
    final useCase = await _getArtistUseCase(id);
    final profileUseCase = await _getProfileUseCase(None());
    final isLiked = profileUseCase.data?.data?.artist
            ?.any((element) => element.data?.id == id) ??
        false;
    userId = profileUseCase.data?.data?.id;
    useCase.fold((data) => _emitData(data, isLiked), emitError);
  }

  _emitData(BaseObjectResponse<SingerModel>? model, bool isLiked) {
    emit(state.copyWith(model: model?.data, isLiked: isLiked));
  }

  void favorite() {
    if (userId == null) {
      return;
    }
    if (state.isLiked) {
      unlike();
    } else {
      like();
    }
  }

  like() async {
    emitLoading();
    final useCase = await _likeUseCase(LikeRequest(
      id: state.model?.id ?? "",
      userId: userId!,
      type: TrackType.artist,
    ));
    useCase.fold(_emitFavorite, emitError);
  }

  unlike() async {
    emitLoading();
    final artists = (await _getProfileUseCase(None())).data?.data?.artist;
    final id = artists
            ?.firstWhereOrNull((element) => element.data?.id == state.model?.id)
            ?.id ??
        0;
    final useCase =
        await _unlikeUseCase(DeleteLikeRequest(id: id, type: TrackType.artist));
    useCase.fold((data) => _emitFavorite(false), emitError);
  }

  _emitFavorite(bool? isFavorite) {
    emit(state.copyWith(isLiked: isFavorite ?? false));
  }
}
