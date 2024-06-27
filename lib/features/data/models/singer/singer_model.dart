import 'package:music_app/features/data/base/base_response.dart';

import '../models.dart';

part 'singer_model.g.dart';

class SingerModel implements BaseDataModel {
  final String? id;

  final String? name;

  final String? thumbnail;

  final String? gender;

  final String? bio;

  final String? birthday;

  final String? nation;

  final List<ChildSongHomeMenuModel>? songs;

  final List<ChildPlaylistHomeMenuModel>? playlist;

  SingerModel({
    this.id,
    this.name,
    this.thumbnail,
    this.songs,
    this.playlist,
    this.gender,
    this.bio,
    this.birthday,
    this.nation,
  });

  @override
  T fromJson<T extends BaseDataModel>(Map<String, dynamic> json) =>
      _$SingerModelFromJson(json) as T;

  factory SingerModel.fromJson(Map<String, dynamic> json) =>
      _$SingerModelFromJson(json);
}
