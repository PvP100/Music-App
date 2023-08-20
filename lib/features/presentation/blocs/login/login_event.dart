part of 'login_bloc.dart';

abstract class LoginEvent {}

class OnLoginEvent extends LoginEvent {
  final String username;
  final String password;

  OnLoginEvent({required this.username, required this.password});
}
