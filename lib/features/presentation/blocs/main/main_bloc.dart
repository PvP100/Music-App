import 'package:music_app/features/presentation/blocs/base/base_bloc.dart';
import 'package:music_app/features/presentation/ui/screen/main/main_screen.dart';

part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends BaseBloc<MainEvent, MainState> {
  MainBloc() : super(MainState());

  @override
  void init() {
    on<OnTabClickEvent>(
      (event, emit) => emit(state.copyWith(currentScreen: event.screen)),
    );
  }
}
