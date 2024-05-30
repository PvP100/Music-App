import 'package:json_annotation/json_annotation.dart';
import 'package:music_app/features/data/models/track/track_model.dart';

part 'list_track_model.g.dart';

@JsonSerializable()
class ListTrackModel {
  final List<TrackModel>? tracks;

  ListTrackModel({this.tracks});

  factory ListTrackModel.fromJson(Map<String, dynamic> json) =>
      _$ListTrackModelFromJson(json);

  Map<String, dynamic> toJson() => _$ListTrackModelToJson(this);
}
