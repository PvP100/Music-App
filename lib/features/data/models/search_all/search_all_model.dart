import 'package:music_app/features/data/base/base_response.dart';

import '../models.dart';

part 'search_all_model.g.dart';

class SearchAllModel implements BaseDataModel {
  final List<SingerModel>? singers;

  final List<SongSearchModel>? songs;

  final List<AlbumModel>? album;

  final List<AlbumModel>? playlist;

  SearchAllModel({this.singers, this.playlist, this.album, this.songs});

  factory SearchAllModel.fromJson(Map<String, dynamic> json) =>
      _$SearchAllModelFromJson(json);

  @override
  T fromJson<T extends BaseDataModel>(Map<String, dynamic> json) =>
      SearchAllModel.fromJson(json) as T;
}

class SongSearchModel {
  final String? id;

  final String? name;

  final String? thumbnail;

  final List<SingerHomeMenuModel>? singers;

  SongSearchModel({this.id, this.name, this.thumbnail, this.singers});

  factory SongSearchModel.fromJson(Map<String, dynamic> json) =>
      _$SongSearchModelFromJson(json);
}
