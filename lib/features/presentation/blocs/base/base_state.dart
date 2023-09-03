part of 'base_bloc.dart';

abstract class BaseState<S> {
  final bool isLoading;
  final Exception? errorMsg;
  const BaseState({this.isLoading = false, this.errorMsg});

  @protected
  S copyWith({bool isLoading = false, Exception? errorMsg});
}
