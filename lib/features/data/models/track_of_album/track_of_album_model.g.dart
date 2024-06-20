// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'track_of_album_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TrackOfAlbumModel _$TrackOfAlbumModelFromJson(Map<String, dynamic> json) =>
    TrackOfAlbumModel(
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => TrackModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TrackOfAlbumModelToJson(TrackOfAlbumModel instance) =>
    <String, dynamic>{
      'items': instance.items,
    };
