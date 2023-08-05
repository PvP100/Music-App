part of 'base_bloc.dart';

abstract class IBaseState {
  final bool isLoading;
  final String? errorMsg;

  IBaseState({this.isLoading = false, this.errorMsg});
}

abstract class BaseState<S extends IBaseState> extends IBaseState {
  BaseState({super.isLoading, super.errorMsg});

  @protected
  S copyWith({bool isLoading = false, String? errorMsg});
}
