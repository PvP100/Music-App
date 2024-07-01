import 'package:json_annotation/json_annotation.dart';
import 'package:music_app/features/data/base/base_response.dart';

import '../models.dart';

part 'profile_model.g.dart';

class Profile implements BaseDataModel {
  @JsonKey(name: "fist_name")
  final String? firstName;

  @JsonKey(name: "last_name")
  final String? lastName;

  final String? email;

  final String? avatar;

  final int? totalSong;

  final List<ChildSongHomeMenuModel>? songs;

  final String? id;

  final List<SingerHomeMenuModel>? artist;

  final List<ChildAlbumHomeMenuModel>? album;

  final List<ChildPlaylistHomeMenuModel>? playlist;

  Profile({
    this.firstName,
    this.songs,
    this.id,
    this.lastName,
    this.email,
    this.avatar,
    this.totalSong,
    this.artist,
    this.album,
    this.playlist,
  });

  @override
  T fromJson<T extends BaseDataModel>(Map<String, dynamic> json) =>
      _$ProfileFromJson(json) as T;
}
