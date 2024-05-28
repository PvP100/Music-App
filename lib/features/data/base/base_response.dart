abstract class BaseDataModel {
  T fromJson<T extends BaseDataModel>(Map<String, dynamic> json);
}

class BaseResponse {
  final int? statusCode;
  final String? msg;

  const BaseResponse({this.statusCode, this.msg});
}

class BaseObjectResponse<R extends BaseDataModel> extends BaseResponse {
  final R? data;

  BaseObjectResponse({super.statusCode, super.msg, this.data});

  factory BaseObjectResponse.fromJson(
    Map<String, dynamic> json,
    R model,
  ) {
    return BaseObjectResponse(
      statusCode: json['code'] != null ? json['code'] as int : null,
      msg: json['msg'] != null ? json['msg'] as String : null,
      data: json['data'] != null
          ? json['data'] is R
              ? (json['data'] as R)
              : model.fromJson<R>(json['data'])
          : null,
    );
  }
}

class BaseListResponse<R extends BaseDataModel> extends BaseResponse {
  final List<R>? data;

  BaseListResponse({super.statusCode, super.msg, this.data});

  factory BaseListResponse.fromJson(Map<String, dynamic> json, R model) {
    List<R>? listData;
    if (json['items'] != null) {
      listData = (json['items'] as List<dynamic>)
          .map((e) => model.fromJson<R>(e))
          .toList();
    }
    return BaseListResponse(
        statusCode: json['code'] != null ? json['code'] as int : null,
        msg: json['msg'] != null ? json['msg'] as String : null,
        data: listData);
  }
}
