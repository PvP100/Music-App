part of 'base_bloc.dart';

abstract class BaseState {
  final bool isLoading;
  final String? errorMsg;

  BaseState({this.isLoading = false, this.errorMsg});

  @protected
  BaseState copyWith({bool isLoading = false, String? errorMsg});
}
