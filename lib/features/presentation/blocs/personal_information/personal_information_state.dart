part of 'personal_information_bloc.dart';

class PersonalInformationState extends BaseState<PersonalInformationState> {
  const PersonalInformationState({super.error, super.isLoading, this.profile});

  final Profile? profile;

  @override
  PersonalInformationState copyWith({
    bool isLoading = false,
    Failure? error,
    Profile? profile,
  }) =>
      PersonalInformationState(
        isLoading: isLoading,
        error: error,
        profile: profile ?? this.profile,
      );
}
