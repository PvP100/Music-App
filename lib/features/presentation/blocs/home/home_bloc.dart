import 'package:music_app/features/domain/usecases/domain_use_cases.dart';
import 'package:music_app/features/domain/usecases/use_case.dart';
import 'package:music_app/features/presentation/blocs/base/base_bloc.dart';

import '../../../data/exception/failure.dart';
import '../../../domain/entities/home_menu_entity.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends BaseBloc<HomeState> {
  final GetHomeMenu _getHomeMenuUseCase;

  HomeBloc(this._getHomeMenuUseCase) : super(const HomeState());

  @override
  void init() {
    getHomeMenu();
  }

  getHomeMenu() async {
    emitLoading();
    final useCase = await _getHomeMenuUseCase(None());
    useCase.fold(_emitData, emitError);
  }

  _emitData(List<HomeMenuEntity>? entities) {
    emit(state.copyWith(entities: entities));
  }
}
