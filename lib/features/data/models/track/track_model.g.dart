// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'track_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TrackModel _$TrackModelFromJson(Map<String, dynamic> json) => TrackModel(
      previewUrl: json['preview_url'] as String?,
      album: json['album'] == null
          ? null
          : AlbumModel.fromJson(json['album'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TrackModelToJson(TrackModel instance) =>
    <String, dynamic>{
      'preview_url': instance.previewUrl,
      'album': instance.album,
    };
