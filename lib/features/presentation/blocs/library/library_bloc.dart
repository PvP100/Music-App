import 'package:music_app/features/presentation/blocs/base/base_bloc.dart';

part 'library_event.dart';
part 'library_state.dart';

class LibraryBloc extends BaseBloc<LibraryEvent, LibraryState> {
  LibraryBloc() : super(LibraryState());
}
