class HomeMenuEntity {
  final String? id;

  final String? title;

  final List<ChildHomeMenuEntity>? data;

  final bool isSong;

  HomeMenuEntity({
    this.id,
    this.title,
    this.data,
    this.isSong = false,
  });
}

class ChildHomeMenuEntity {
  final String? id;

  final String? name;

  final String? artists;

  final String? thumbnail;

  ChildHomeMenuEntity({this.id, this.name, this.artists, this.thumbnail});
}
