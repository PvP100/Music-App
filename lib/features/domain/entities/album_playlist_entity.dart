import 'package:music_app/features/data/models/models.dart';

class AlbumPlaylistEntity {
  final String? id;

  final String? name;

  final String? thumbnail;

  final List<ChildSongHomeMenuModel>? songs;

  AlbumPlaylistEntity({this.id, this.name, this.thumbnail, this.songs});
}
