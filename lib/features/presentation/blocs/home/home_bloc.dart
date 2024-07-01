import 'package:music_app/features/data/base/base_response.dart';
import 'package:music_app/features/data/models/profile/profile_model.dart';
import 'package:music_app/features/domain/usecases/domain_use_cases.dart';
import 'package:music_app/features/domain/usecases/use_case.dart';
import 'package:music_app/features/presentation/blocs/base/base_bloc.dart';

import '../../../data/exception/failure.dart';
import '../../../domain/entities/home_menu_entity.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends BaseBloc<HomeState> {
  final GetHomeMenu _getHomeMenuUseCase;

  final GetProfile _getProfileUseCase;

  HomeBloc(this._getHomeMenuUseCase, this._getProfileUseCase)
      : super(const HomeState());

  @override
  void init() {
    getHomeMenu();
    getProfile();
  }

  getProfile() async {
    final useCase = await _getProfileUseCase(None());
    useCase.fold(_emitDataProfile, emitError);
  }

  getHomeMenu() async {
    emitLoading();
    final useCase = await _getHomeMenuUseCase(None());
    useCase.fold(_emitData, emitError);
  }

  _emitData(List<HomeMenuEntity>? entities) {
    emit(state.copyWith(entities: entities));
  }

  _emitDataProfile(BaseObjectResponse<Profile>? p) {
    emit(state.copyWith(profile: p?.data));
  }
}
