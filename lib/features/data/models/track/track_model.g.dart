// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'track_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TrackModel _$TrackModelFromJson(Map<String, dynamic> json) => TrackModel(
    previewUrl: json['preview_url'] as String?,
    album: null,
    // : AlbumModel.fromJson(json['album'] as Map<String, dynamic>),
    durationMs: json['duration'] as double?,
    name: json['name'] as String?,
    thumbnailId: json['thumbnail'] as String?,
    fileId: json['file'] as String?,
    id: json['id'] as String?,
    singers: (json['singers'] as List<dynamic>)
        .map((e) => SingerHomeMenuModel.fromJson(e as Map<String, dynamic>))
        .toList());

Map<String, dynamic> _$TrackModelToJson(TrackModel instance) =>
    <String, dynamic>{
      'preview_url': instance.previewUrl,
      'album': instance.album,
      'duration_ms': instance.durationMs,
    };
