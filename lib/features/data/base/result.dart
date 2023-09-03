sealed class Result<T> {
  final T? data;
  final Exception? error;

  Result({this.data, this.error});

  factory Result.success(T? data) = ResultSuccess<T>;
  factory Result.error(Exception error) = ResultError;

  void fold(Function(T? data) onSuccess,
      [Function(Exception exception)? onFailure]) {
    switch (this) {
      case ResultSuccess():
        onSuccess(data);
      case ResultError():
        onFailure?.call(error!);
    }
  }
}

class ResultSuccess<T> extends Result<T> {
  final T? resultData;
  ResultSuccess(this.resultData) : super(data: resultData);
}

class ResultError extends Result<Never> {
  final Exception resultError;
  ResultError(this.resultError) : super(error: resultError);
}
