part of 'base_bloc.dart';

abstract class IBaseState {
  final bool isLoading;
  final String? errorMsg;

  IBaseState({this.isLoading = false, this.errorMsg});
}

abstract class BaseState {
  final bool isLoading;
  final String? errorMsg;

  BaseState({this.isLoading = false, this.errorMsg});

  @protected
  BaseState copyWith({bool isLoading = false, String? errorMsg});
}
