import 'package:music_app/features/data/base/base_response.dart';
import 'package:music_app/features/data/models/models.dart';

part 'home_menu_model.g.dart';

class HomeMenuModel implements BaseDataModel {
  final String? id;

  final String? title;

  final List<ChildSongHomeMenuModel>? songs;

  final List<ChildAlbumHomeMenuModel>? albums;

  final List<ChildPlaylistHomeMenuModel>? playlist;

  HomeMenuModel({this.id, this.title, this.songs, this.albums, this.playlist});

  @override
  T fromJson<T extends BaseDataModel>(Map<String, dynamic> json) =>
      _$HomeMenuModelFromJson(json) as T;
}

class ChildSongHomeMenuModel {
  final int? id;
  final SongHomeMenu? data;

  ChildSongHomeMenuModel({this.data, this.id});

  factory ChildSongHomeMenuModel.fromJson(Map<String, dynamic> json) =>
      _$ChildSongHomeMenuModelFromJson(json);
}

class ChildAlbumHomeMenuModel {
  final int? id;
  final SongHomeMenu? data;

  ChildAlbumHomeMenuModel({this.data, this.id});

  factory ChildAlbumHomeMenuModel.fromJson(Map<String, dynamic> json) =>
      _$ChildAlbumHomeMenuModelFromJson(json);
}

class ChildPlaylistHomeMenuModel {
  final int? id;
  final SongHomeMenu? data;

  ChildPlaylistHomeMenuModel({
    this.data,
    this.id,
  });

  factory ChildPlaylistHomeMenuModel.fromJson(Map<String, dynamic> json) =>
      _$ChildPlaylistHomeMenuModelFromJson(json);
}

class SingerHomeMenuModel {
  final SingerModel? data;
  final int? id;

  SingerHomeMenuModel({this.data, this.id});

  factory SingerHomeMenuModel.fromJson(Map<String, dynamic> json) =>
      _$SingerHomeMenuModelFromJson(json);
}

class SongHomeMenu {
  final String? id;

  final String? name;

  final String? thumbnail;

  final List<SingerHomeMenuModel>? singers;

  SongHomeMenu({this.id, this.name, this.thumbnail, this.singers});

  factory SongHomeMenu.fromJson(Map<String, dynamic> json) =>
      _$SongHomeMenuModelFromJson(json);
}
