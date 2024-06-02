// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginModel _$LoginModelFromJson(Map<String, dynamic> json) => LoginModel(
      name: json['token_type'] as String? ?? "",
      accessToken: json['access_token'] as String? ?? "",
      expiresIn: json['expires_in'] as int? ?? 0,
    );

Map<String, dynamic> _$LoginModelToJson(LoginModel instance) =>
    <String, dynamic>{
      'token_type': instance.name,
      'access_token': instance.accessToken,
      'expires_in': instance.expiresIn,
    };
