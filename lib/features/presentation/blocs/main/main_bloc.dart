import 'package:music_app/features/data/exception/failure.dart';
import 'package:music_app/features/presentation/blocs/base/base_bloc.dart';
import 'package:music_app/features/presentation/ui/screen/main/main_screen.dart';

part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends BaseBloc<MainState> {
  MainBloc() : super(MainState());

  changScreen(TabNavigation tabNavigation) {
    emit(state.copyWith(currentScreen: tabNavigation));
  }
}
