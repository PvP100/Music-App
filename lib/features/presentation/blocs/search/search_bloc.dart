import 'package:music_app/features/data/exception/failure.dart';
import 'package:music_app/features/presentation/blocs/base/base_bloc.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends BaseBloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchState());
}
