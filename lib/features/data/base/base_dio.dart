import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:music_app/features/data/base/base_response.dart';
import 'result.dart';

abstract class IBaseDio {
  Future<Result<T>> request<T extends BaseDataModel>(
    String path, {
    ApiMethod method = ApiMethod.get,
    T Function(Map<String, dynamic>)? fromJson,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? part,
  });
}

class BaseDio implements IBaseDio {
  final Dio _dio;

  BaseDio(this._dio);

  @override
  Future<Result<T>> request<T extends BaseDataModel>(
    String path, {
    ApiMethod method = ApiMethod.get,
    T Function(Map<String, dynamic>)? fromJson,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? part,
  }) async {
    try {
      final response = await _dio.request(path,
          data: part,
          options: Options(method: method.value),
          queryParameters: queryParameters);
      final data = response.data;
      late List<T> model;
      if (fromJson != null) {
        model = [fromJson(response.data)];
      } else {
        final baseModel = GetIt.I.get<T>();
        if (data is List<dynamic>) {
          model = data.map((e) => baseModel.fromJson<T>(e)).toList();
        } else {
          model = [baseModel.fromJson<T>(response.data)];
        }
      }
      return ResultSuccess(model);
    } on StateError catch (e) {
      return ResultError(Exception(e.message));
    } on Exception catch (e) {
      return ResultError(e);
    }
  }
}

enum ApiMethod {
  post("POST"),
  put("PUT"),
  delete("DELETE"),
  get("GET");

  const ApiMethod(this.value);
  final String value;
}
