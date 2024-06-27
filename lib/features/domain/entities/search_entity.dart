class SearchEntity {
  final String? id;
  final String? image;
  final String? name;
  final String? artist;
  final TrackType? type;

  SearchEntity({this.id, this.type, this.artist, this.name, this.image});
}

enum TrackType { song, artist, album, playlist }
