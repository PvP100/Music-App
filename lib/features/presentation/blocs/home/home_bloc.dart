import 'package:music_app/features/presentation/blocs/base/base_bloc.dart';

import '../../../data/exception/failure.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends BaseBloc<HomeState> {
  HomeBloc() : super(const HomeState());

  @override
  void init() {}
}
