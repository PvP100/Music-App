import 'package:dio/dio.dart';
import 'package:music_app/config/config.dart';
import 'package:music_app/features/data/exception/failure.dart';
import 'result.dart';

abstract class IBaseDio {
  Future<Result<T>> request<T>(
    String path, {
    required T Function(Map<String, dynamic> json) fromJson,
    ApiMethod method = ApiMethod.get,
    Map<String, dynamic>? queryParameters,
    Object? part,
  });
}

class BaseDio implements IBaseDio {
  final Dio _dio;

  BaseDio(this._dio);

  @override
  Future<Result<T>> request<T>(
    String path, {
    required T Function(Map<String, dynamic> json) fromJson,
    ApiMethod method = ApiMethod.get,
    Map<String, dynamic>? queryParameters,
    Object? part,
  }) async {
    if (await NetworkConnectivity.status) {
      try {
        final response = await _dio.request(path,
            data: part,
            options: Options(method: method.value),
            queryParameters: queryParameters);
        final data = response.data;
        final statusCode = response.statusCode ?? -1;
        return switch (statusCode) {
          >= 200 && < 300 =>
            Result.success(fromJson(data is String ? {} : data)),
          _ => Result.error(Failure.serverError()),
        };
      } on DioException catch (e) {
        final statusCode = e.response?.statusCode ?? -1;
        return switch (statusCode) {
          400 => Result.error(Failure.badRequestError()),
          401 => Result.error(Failure.unAuthorizedError((((e.response?.data
                  as Map<String, dynamic>)['errors'] as List<dynamic>)
              .firstOrNull as Map<String, dynamic>)['message'])),
          404 => Result.error(Failure.dataNotFoundError()),
          500 => Result.error(Failure.internalServerError()),
          _ => Result.error(Failure.serverError()),
        };
      }
    } else {
      return ResultError(Failure.networkConnection());
    }
  }
}

enum ApiMethod {
  post("POST"),
  put("PUT"),
  patch("PATCH"),
  delete("DELETE"),
  get("GET");

  const ApiMethod(this.value);
  final String value;
}
