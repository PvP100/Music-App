import 'package:music_app/features/data/base/base_response.dart';
import 'package:music_app/features/data/exception/failure.dart';
import 'package:music_app/features/data/models/models.dart';
import 'package:music_app/features/domain/usecases/domain_use_cases.dart';
import 'package:music_app/features/domain/usecases/use_case.dart';
import 'package:music_app/features/presentation/blocs/base/base_bloc.dart';

part 'profile_state.dart';
part 'profile_event.dart';

class ProfileBloc extends BaseBloc<ProfileState> {
  final GetProfile _getProfileUseCase;

  ProfileBloc(this._getProfileUseCase) : super(const ProfileState());

  @override
  void init() {
    getProfile();
  }

  getProfile() async {
    emitLoading();
    final useCase = await _getProfileUseCase(None());
    useCase.fold(_emitProfile, emitError);
  }

  _emitProfile(BaseObjectResponse<Profile>? response) {
    emit(state.copyWith(profile: response?.data));
  }
}
