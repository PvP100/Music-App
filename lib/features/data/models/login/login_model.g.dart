// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginModel _$LoginModelFromJson(Map<String, dynamic> json) => LoginModel(
      refreshToken: json['refresh_token'] as String? ?? "",
      accessToken: json['access_token'] as String? ?? "",
      expiresIn: json['expires'] as int? ?? 0,
    );

Map<String, dynamic> _$LoginModelToJson(LoginModel instance) =>
    <String, dynamic>{
      'refresh_token': instance.refreshToken,
      'access_token': instance.accessToken,
      'expires_in': instance.expiresIn,
    };
