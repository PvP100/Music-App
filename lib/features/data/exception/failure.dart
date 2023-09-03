class NetWorkConnection implements Failure {}

class BadRequestError implements Failure {}

class UnAuthorizedError implements Failure {}

class DataNotFoundError implements Failure {}

class InternalServerError implements Failure {}

class ServerError implements Failure {}

class AppError implements Failure {
  final String message;
  AppError(this.message);
}

sealed class Failure implements Exception {
  factory Failure.networkConnection() = NetWorkConnection;
  factory Failure.badRequestError() = BadRequestError;
  factory Failure.unAuthorizedError() = UnAuthorizedError;
  factory Failure.dataNotFoundError() = DataNotFoundError;
  factory Failure.internalServerError() = InternalServerError;
  factory Failure.serverError() = ServerError;
  factory Failure.error(String message) = AppError;
}
