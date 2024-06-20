// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'album_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AlbumModel _$AlbumModelFromJson(Map<String, dynamic> json) => AlbumModel(
      albumType: $enumDecodeNullable(_$AlbumTypeEnumMap, json['album_type']),
      images: (json['images'] as List<dynamic>?)
          ?.map((e) => AlbumImageModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      name: json['name'] as String?,
      artists: (json['artists'] as List<dynamic>?)
          ?.map((e) => ArtistsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      tracks: TrackOfAlbumModel.fromJson(json['tracks']),
    );

Map<String, dynamic> _$AlbumModelToJson(AlbumModel instance) =>
    <String, dynamic>{
      'album_type': _$AlbumTypeEnumMap[instance.albumType],
      'artists': instance.artists,
      'name': instance.name,
      'images': instance.images,
    };

const _$AlbumTypeEnumMap = {
  AlbumType.album: 'album',
  AlbumType.single: 'single',
};

AlbumImageModel _$AlbumImageModelFromJson(Map<String, dynamic> json) =>
    AlbumImageModel(
      url: json['url'] as String?,
      height: json['height'] as int?,
      width: json['width'] as int?,
    );

Map<String, dynamic> _$AlbumImageModelToJson(AlbumImageModel instance) =>
    <String, dynamic>{
      'url': instance.url,
      'height': instance.height,
      'width': instance.width,
    };

ArtistsModel _$ArtistsModelFromJson(Map<String, dynamic> json) => ArtistsModel(
      name: json['name'] as String?,
      id: json['id'] as String?,
    );

Map<String, dynamic> _$ArtistsModelToJson(ArtistsModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
    };
