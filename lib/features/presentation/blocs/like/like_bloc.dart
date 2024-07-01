import 'package:music_app/features/data/exception/failure.dart';
import 'package:music_app/features/data/models/home_menu/home_menu_model.dart';
import 'package:music_app/features/domain/entities/object_list_entity.dart';
import 'package:music_app/features/domain/usecases/domain_use_cases.dart';
import 'package:music_app/features/domain/usecases/use_case.dart';
import 'package:music_app/features/presentation/blocs/base/base_bloc.dart';

part 'like_state.dart';

class LikeBloc extends BaseBloc<LikeState> {
  final GetProfile _getProfileUseCase;

  LikeBloc(this._getProfileUseCase) : super(const LikeState());

  @override
  void init() {
    getProfile(true);
  }

  getProfile([bool showLoading = false]) async {
    if (showLoading) {
      emitLoading();
    }
    final useCase = await _getProfileUseCase(None());
    useCase.fold((data) {
      emit(state.copyWith(songs: ObjectListEntity(data?.data?.songs ?? [])));
    }, emitError);
  }
}
