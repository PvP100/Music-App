// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Profile _$ProfileFromJson(Map<String, dynamic> json) => Profile(
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      email: json['email'] as String?,
      avatar: json['avatar'] as String?,
      id: json['id'] as String?,
      totalSong: (json['song_liked'] as List<dynamic>).length,
      songs: (json['song_liked'] as List<dynamic>)
          .map(
              (e) => ChildSongHomeMenuModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      artist: (json['artist_liked'] as List<dynamic>)
          .map((e) => SingerHomeMenuModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      album: (json['album_liked'] as List<dynamic>)
          .map((e) =>
              ChildAlbumHomeMenuModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      playlist: (json['user_playlist'] as List<dynamic>)
          .map((e) =>
              ChildPlaylistHomeMenuModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
      'first_name': instance.firstName,
      'last_name': instance.lastName,
    };
