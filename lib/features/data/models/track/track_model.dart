import 'package:json_annotation/json_annotation.dart';
import 'package:music_app/features/data/base/base_response.dart';
import 'package:music_app/features/data/models/album/album_model.dart';

import '../models.dart';

part 'track_model.g.dart';

@JsonSerializable()
class TrackModel extends BaseDataModel {
  @JsonKey(name: "preview_url")
  final String? previewUrl;

  final AlbumModel? album;

  @JsonKey(name: "duration_ms")
  final int? durationMs;

  @JsonKey(name: "name")
  final String? name;

  @JsonKey(name: "file")
  final String? fileId;

  @JsonKey(name: "thumbnail")
  final String? thumbnailId;

  @JsonKey(name: "id")
  final String? id;

  @JsonKey(name: "singers")
  final List<SingerHomeMenuModel>? singers;

  factory TrackModel.fromJson(Map<String, dynamic> json) =>
      _$TrackModelFromJson(json);

  Map<String, dynamic> toJson() => _$TrackModelToJson(this);

  TrackModel({
    this.previewUrl,
    this.album,
    this.durationMs,
    this.fileId,
    this.name,
    this.thumbnailId,
    this.id,
    this.singers,
  });

  @override
  T fromJson<T extends BaseDataModel>(Map<String, dynamic> json) =>
      TrackModel.fromJson(json) as T;
}
