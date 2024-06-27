// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'album_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AlbumModel _$AlbumModelFromJson(Map<String, dynamic> json) => AlbumModel(
    albumType: $enumDecodeNullable(_$AlbumTypeEnumMap, json['album_type']),
    thumbnail: (json['thumbnail'] is Map<String, dynamic>
        ? json['thumbnail']['id'] as String?
        : json['thumbnail'] as String?),
    name: json['name'] as String?,
    id: json['id'] as String?,
    artists: (json['artists'] as List<dynamic>?)
        ?.map((e) => ArtistsModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    singers: (json['singers'] as List<dynamic>)
        .map((e) => SingerHomeMenuModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    songs: (json['songs'] as List<dynamic>)
        .map((e) => ChildSongHomeMenuModel.fromJson(e as Map<String, dynamic>))
        .toList());

Map<String, dynamic> _$AlbumModelToJson(AlbumModel instance) =>
    <String, dynamic>{
      'album_type': _$AlbumTypeEnumMap[instance.albumType],
      'artists': instance.artists,
      'name': instance.name,
      'images': instance.thumbnail,
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
