import 'package:music_app/features/presentation/blocs/base/base_bloc.dart';
part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends BaseBloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashState());
}
