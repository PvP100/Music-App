// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_menu_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeMenuModel _$HomeMenuModelFromJson(Map<String, dynamic> json) =>
    HomeMenuModel(
        title: json['title'] as String?,
        id: json['id'] as String?,
        songs: (json['songs'] as List<dynamic>)
            .map((e) =>
                ChildSongHomeMenuModel.fromJson(e as Map<String, dynamic>))
            .toList(),
        albums: (json['albums'] as List<dynamic>)
            .map((e) =>
                ChildAlbumHomeMenuModel.fromJson(e as Map<String, dynamic>))
            .toList());

Map<String, dynamic> _$HomeMenuModelToJson(HomeMenuModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
    };

ChildSongHomeMenuModel _$ChildSongHomeMenuModelFromJson(
        Map<String, dynamic> json) =>
    ChildSongHomeMenuModel(
      data: SongHomeMenu.fromJson(json['Song_id'] as Map<String, dynamic>),
    );

ChildAlbumHomeMenuModel _$ChildAlbumHomeMenuModelFromJson(
        Map<String, dynamic> json) =>
    ChildAlbumHomeMenuModel(
      data: SongHomeMenu.fromJson(json['Album_id'] as Map<String, dynamic>),
    );

SingerHomeMenuModel _$SingerHomeMenuModelFromJson(Map<String, dynamic> json) =>
    SingerHomeMenuModel(
      data: SingerModel.fromJson(json['Singer_id'] as Map<String, dynamic>),
    );

SongHomeMenu _$SongHomeMenuModelFromJson(Map<String, dynamic> json) =>
    SongHomeMenu(
      id: json['id'] as String?,
      name: json['name'] as String?,
      thumbnail: json['thumbnail'] as String?,
      singers: (json['singers'] as List<dynamic>)
          .map((e) => SingerHomeMenuModel.fromJson(e))
          .toList(),
    );
