abstract class Result<T> {
  final List<T>? data;
  final Exception? error;

  Result({this.data, this.error});

  void fold(Function(List<T>? data) onSuccess,
      [Function(Exception exception)? onFailure]) {
    if (this is ResultSuccess) {
      onSuccess(data);
    } else if (this is ResultError) {
      onFailure?.call(error!);
    }
  }
}

class ResultSuccess<T> extends Result<T> {
  final List<T>? responseData;
  ResultSuccess(this.responseData) : super(data: responseData);
}

class ResultError extends Result<Never> {
  final Exception resultError;
  ResultError(this.resultError) : super(error: resultError);
}
