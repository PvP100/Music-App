import 'package:music_app/features/data/exception/failure.dart';
import 'package:music_app/features/presentation/blocs/base/base_bloc.dart';

part 'profile_state.dart';
part 'profile_event.dart';

class ProfileBloc extends BaseBloc<ProfileState> {
  ProfileBloc() : super(const ProfileState());
}
