part of 'register_bloc.dart';

abstract class RegisterEvent {}

class OnBirthdaySelectedEvent extends RegisterEvent {
  final DateTime birthday;
  OnBirthdaySelectedEvent(this.birthday);
}

class OnRegisterEvent extends RegisterEvent {
  final String username;
  final String password;
  final String rePassword;
  final String fullName;

  OnRegisterEvent({
    required this.username,
    required this.password,
    required this.rePassword,
    required this.fullName,
  });
}
