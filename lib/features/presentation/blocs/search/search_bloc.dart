import 'package:music_app/features/data/exception/failure.dart';
import 'package:music_app/features/domain/entities/enum/search_type.dart';
import 'package:music_app/features/domain/entities/object_list_entity.dart';
import 'package:music_app/features/domain/entities/search_entity.dart';
import 'package:music_app/features/domain/usecases/domain_use_cases.dart';
import 'package:music_app/features/presentation/blocs/base/base_bloc.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends BaseBloc<SearchState> {
  final SearchAll _searchAllUseCase;

  SearchBloc(this._searchAllUseCase) : super(SearchState());

  search(String keyword, SearchType type) async {
    emitLoading();
    final useCase = await _searchAllUseCase({keyword: type});
    useCase.fold(emitData, emitError);
  }

  emitData(List<SearchEntity>? data) {
    emit(state.copyWith(data: ObjectListEntity(data ?? [])));
  }
}
