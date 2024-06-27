import '../exception/failure.dart';

sealed class Result<T> {
  final T? data;
  final Failure? error;

  Result({this.data, this.error});

  factory Result.success(T? data) = ResultSuccess<T>;
  factory Result.error(Failure error) = ResultError;

  void fold(Function(T? data) onSuccess,
      [Function(Failure exception)? onFailure]) {
    switch (this) {
      case ResultSuccess():
        onSuccess(data);
      case ResultError():
        onFailure?.call(error!);
    }
  }

  Result<E> convert<E>(E? Function(T? data) onSuccess) {
    switch (this) {
      case ResultSuccess():
        return Result.success(onSuccess(data));
      case ResultError():
        return Result.error(error!);
    }
  }
}

class ResultSuccess<T> extends Result<T> {
  final T? resultData;
  ResultSuccess(this.resultData) : super(data: resultData);
}

class ResultError extends Result<Never> {
  final Failure resultError;
  ResultError(this.resultError) : super(error: resultError);
}
