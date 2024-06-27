// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_all_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchAllModel _$SearchAllModelFromJson(Map<String, dynamic> json) =>
    SearchAllModel(
      singers: (json['Singer'] as List<dynamic>)
          .map((e) => SingerModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      songs: (json['Song'] as List<dynamic>)
          .map((e) => SongSearchModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      album: (json['Album'] as List<dynamic>)
          .map((e) => AlbumModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      playlist: (json['Playlist'] as List<dynamic>)
          .map((e) => AlbumModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

SongSearchModel _$SongSearchModelFromJson(Map<String, dynamic> json) =>
    SongSearchModel(
      id: json['id'] as String?,
      name: json['name'] as String?,
      thumbnail:
          json['thumbnail'] != null ? json['thumbnail']['id'] as String? : null,
      singers: (json['singers'] as List<dynamic>)
          .map((e) => SingerHomeMenuModel.fromJson(e))
          .toList(),
    );
