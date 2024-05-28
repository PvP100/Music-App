import 'package:music_app/features/data/exception/failure.dart';
import 'package:music_app/features/presentation/blocs/base/base_bloc.dart';

import '../../../data/models/models.dart';
import '../../../domain/usecases/get_categories.dart';
import '../../../domain/usecases/use_case.dart';

part 'category_state.dart';

class CategoryBloc extends BaseBloc<CategoryState> {
  CategoryBloc(this._getCategoriesUseCase) : super(const CategoryState());

  final GetCategories _getCategoriesUseCase;

  getCategories() async {
    emitLoading();
    final useCase = await _getCategoriesUseCase(None());
    useCase.fold((data) {
      emit(state.copyWith(categories: data?.categories?.data));
    }, emitError);
  }
}
