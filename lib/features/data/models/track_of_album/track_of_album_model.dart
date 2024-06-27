import 'package:json_annotation/json_annotation.dart';
import 'package:music_app/features/data/models/track/track_model.dart';

part 'track_of_album_model.g.dart';

@JsonSerializable()
class TrackOfAlbumModel {
  final List<TrackModel>? items;

  TrackOfAlbumModel({this.items});

  factory TrackOfAlbumModel.fromJson(Map<String, dynamic> json) =>
      _$TrackOfAlbumModelFromJson(json);
}
