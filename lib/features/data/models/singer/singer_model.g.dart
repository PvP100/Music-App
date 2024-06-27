// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'singer_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SingerModel _$SingerModelFromJson(Map<String, dynamic> json) => SingerModel(
      id: json['id'] as String?,
      thumbnail: json['thumbnail'] is Map<String, dynamic>
          ? json['thumbnail']['id'] as String
          : json['thumbnail'] as String?,
      name: json['name'] as String?,
      bio: json['bio'] as String?,
      birthday: json['birthday'] as String?,
      nation: json['nation'] as String?,
      gender: json['gender'] as String?,
      songs: (json['songs'] as List<dynamic>?)
          ?.map(
            (e) => e is int
                ? ChildSongHomeMenuModel()
                : ChildSongHomeMenuModel.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
      playlist: (json['playlist'] as List<dynamic>?)
          ?.map(
            (e) => e is int
                ? ChildPlaylistHomeMenuModel()
                : ChildPlaylistHomeMenuModel.fromJson(
                    e as Map<String, dynamic>),
          )
          .toList(),
    );

Map<String, dynamic> _$SingerModelToJson(SingerModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'thumbnail': instance.thumbnail,
      'name': instance.name,
    };
