part of 'profile_bloc.dart';

class ProfileState extends BaseState<ProfileState> {
  final Profile? profile;

  const ProfileState({this.profile, super.error, super.isLoading});

  @override
  ProfileState copyWith({
    bool isLoading = false,
    Failure? error,
    Profile? profile,
  }) {
    return ProfileState(
      profile: profile ?? this.profile,
      isLoading: isLoading,
      error: error,
    );
  }
}
