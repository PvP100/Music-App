import 'package:json_annotation/json_annotation.dart';

part 'album_model.g.dart';

@JsonSerializable()
class AlbumModel {
  @JsonKey(name: "album_type")
  final AlbumType? albumType;

  @JsonKey(name: "artists")
  final List<ArtistsModel>? artists;

  @JsonKey(name: "name")
  final String? name;

  final List<AlbumImageModel>? images;

  AlbumModel({this.albumType, this.images, this.name, this.artists});

  factory AlbumModel.fromJson(Map<String, dynamic> json) =>
      _$AlbumModelFromJson(json);
}

@JsonSerializable()
class AlbumImageModel {
  final String? url;

  final int? height;

  final int? width;

  AlbumImageModel({this.url, this.height, this.width});

  factory AlbumImageModel.fromJson(Map<String, dynamic> json) =>
      _$AlbumImageModelFromJson(json);
}

@JsonSerializable()
class ArtistsModel {
  @JsonKey(name: "name")
  final String? name;

  @JsonKey(name: "id")
  final String? id;

  ArtistsModel({this.name, this.id});

  factory ArtistsModel.fromJson(Map<String, dynamic> json) =>
      _$ArtistsModelFromJson(json);
}

enum AlbumType {
  @JsonValue("album")
  album,

  @JsonValue("single")
  single,
}