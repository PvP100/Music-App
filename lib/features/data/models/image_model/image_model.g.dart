// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImageModel _$ImageModelFromJson(Map<String, dynamic> json) => ImageModel(
      width: json['width'] as int?,
      height: json['height'] as int?,
      altDescription: json['title'] as String?,
      urls: json['urls'] == null
          ? null
          : UrlsModel.fromJson(json['urls'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ImageModelToJson(ImageModel instance) =>
    <String, dynamic>{
      'width': instance.width,
      'height': instance.height,
      'title': instance.altDescription,
      'urls': instance.urls,
    };

UrlsModel _$UrlsModelFromJson(Map<String, dynamic> json) => UrlsModel(
      json['raw'] as String?,
      json['full'] as String?,
      json['regular'] as String?,
      json['small'] as String?,
      json['thumb'] as String?,
      json['small_s3'] as String?,
    );

Map<String, dynamic> _$UrlsModelToJson(UrlsModel instance) => <String, dynamic>{
      'raw': instance.raw,
      'full': instance.full,
      'regular': instance.regular,
      'small': instance.small,
      'thumb': instance.thumb,
      'small_s3': instance.smallS3,
    };
