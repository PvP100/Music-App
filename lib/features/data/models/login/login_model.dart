import 'package:json_annotation/json_annotation.dart';
import 'package:music_app/features/data/base/base_response.dart';

part 'login_model.g.dart';

@JsonSerializable()
class LoginModel implements BaseDataModel {
  @JsonKey(name: "refresh_token")
  final String refreshToken;

  @JsonKey(name: "access_token")
  final String accessToken;

  @JsonKey(name: "expires")
  final int expiresIn;

  LoginModel(
      {this.refreshToken = "", this.accessToken = "", this.expiresIn = 0});

  factory LoginModel.fromJson(Map<String, dynamic> json) =>
      _$LoginModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoginModelToJson(this);

  @override
  T fromJson<T extends BaseDataModel>(Map<String, dynamic> json) =>
      LoginModel.fromJson(json) as T;
}
