import 'package:get_it/get_it.dart';

abstract class BaseDataModel {
  T fromJson<T extends BaseDataModel>(Map<String, dynamic> json);
}

class BaseResponse {
  final int? statusCode;
  final String? msg;

  BaseResponse({this.statusCode, this.msg});
}

class BaseObjectResponse<R extends BaseDataModel> extends BaseResponse
    implements BaseDataModel {
  final R? data;

  BaseObjectResponse({super.statusCode, super.msg, this.data});

  factory BaseObjectResponse.fromJson(Map<String, dynamic> json) {
    final data = GetIt.I.get<R>().fromJson<R>(json['data'] ?? {});
    return BaseObjectResponse(
        statusCode: json['code'] != null ? json['code'] as int : null,
        msg: json['msg'] != null ? json['msg'] as String : null,
        data: json['data'] is R ? (json['data'] as R) : data);
  }

  @override
  T fromJson<T extends BaseDataModel>(Map<String, dynamic> json) =>
      BaseObjectResponse.fromJson(json) as T;
}

class BaseListResponse<R extends BaseDataModel> extends BaseResponse {
  final List<R>? data;

  BaseListResponse({super.statusCode, super.msg, this.data});

  factory BaseListResponse.fromJson(Map<String, dynamic> json, R model) {
    List<R>? listData;
    if (json['data'] != null) {
      listData = (json['data'] as List<dynamic>).map((e) {
        return model.fromJson<R>(e);
      }).toList();
    }
    return BaseListResponse(
        statusCode: json['code'] != null ? json['code'] as int : null,
        msg: json['msg'] != null ? json['msg'] as String : null,
        data: listData);
  }
}
