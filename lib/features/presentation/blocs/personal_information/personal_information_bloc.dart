import 'package:dio/dio.dart';
import 'package:music_app/features/data/base/base_response.dart';
import 'package:music_app/features/domain/usecases/domain_use_cases.dart';
import 'package:music_app/features/domain/usecases/update_profile.dart';
import 'package:music_app/features/domain/usecases/use_case.dart';
import 'package:music_app/features/presentation/blocs/app/app_bloc.dart';
import 'package:music_app/features/presentation/blocs/base/base_bloc.dart';

import '../../../data/exception/failure.dart';
import '../../../data/models/models.dart';

part 'personal_information_state.dart';

class PersonalInformationBloc extends BaseBloc<PersonalInformationState> {
  final GetProfile _getProfile;

  final UpdateProfile _updateProfileUseCase;

  final UploadFile _uploadFileUseCase;

  final AppBloc _appBloc;

  PersonalInformationBloc(this._appBloc, this._getProfile,
      this._updateProfileUseCase, this._uploadFileUseCase)
      : super(const PersonalInformationState());

  @override
  void init() {
    getProfile();
  }

  getProfile() async {
    emitLoading();
    final useCase = await _getProfile(None());
    useCase.fold(_emitData, emitError);
  }

  updateAvatar(String path) async {
    emitLoading();
    MultipartFile file = await MultipartFile.fromFile(path);
    final uploadFileUseCase = await _uploadFileUseCase(file);
    uploadFileUseCase.fold((data) {
      updateProfile({"avatar": data?.data?.id});
    }, emitError);
  }

  updateProfile(
    Map<String, dynamic> request,
  ) async {
    emitLoading();
    final useCase = await _updateProfileUseCase(request);
    useCase.fold(_emitData, emitError);
  }

  _emitData(BaseObjectResponse<Profile>? data) {
    _appBloc.updateProfile();
    emit(state.copyWith(profile: data?.data));
  }
}
