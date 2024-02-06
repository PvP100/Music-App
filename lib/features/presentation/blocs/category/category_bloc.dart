import 'package:music_app/features/data/exception/failure.dart';
import 'package:music_app/features/presentation/blocs/base/base_bloc.dart';

part 'category_state.dart';

class CategoryBloc extends BaseBloc<CategoryState> {
  CategoryBloc() : super(const CategoryState());
}
