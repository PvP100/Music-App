import 'package:json_annotation/json_annotation.dart';

part 'login_model.g.dart';

@JsonSerializable()
class LoginModel {
  @JsonKey(name: "token_type")
  final String name;

  @JsonKey(name: "access_token")
  final String accessToken;

  @JsonKey(name: "expires_in")
  final int expiresIn;

  LoginModel({this.name = "", this.accessToken = "", this.expiresIn = 0});

  factory LoginModel.fromJson(Map<String, dynamic> json) =>
      _$LoginModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoginModelToJson(this);
}
