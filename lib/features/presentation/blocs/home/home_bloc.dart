import 'package:music_app/features/domain/usecases/get_product.dart';
import 'package:music_app/features/domain/usecases/use_case.dart';
import 'package:music_app/features/presentation/blocs/base/base_bloc.dart';

import '../../../data/exception/failure.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends BaseBloc<HomeState> {
  HomeBloc(this._getRandomImageUseCase) : super(const HomeState());

  final GetRandomImage _getRandomImageUseCase;

  @override
  void init() {
    getRandomImage();
  }

  getRandomImage() async {
    emit(state.copyWith(isLoading: true));
    (await _getRandomImageUseCase(None())).fold((data) {
      emit(state.copyWith(imageUrl: data?.urls?.raw));
    }, (error) {
      emit(state.copyWith(error: error));
    });
  }
}
