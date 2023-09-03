import 'package:music_app/features/presentation/blocs/base/base_bloc.dart';

import '../../../data/exception/failure.dart';

part 'library_event.dart';
part 'library_state.dart';

class LibraryBloc extends BaseBloc<LibraryEvent, LibraryState> {
  LibraryBloc() : super(LibraryState());
}
