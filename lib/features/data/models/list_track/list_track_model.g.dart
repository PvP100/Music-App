// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_track_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListTrackModel _$ListTrackModelFromJson(Map<String, dynamic> json) =>
    ListTrackModel(
      tracks: (json['tracks'] as List<dynamic>?)
          ?.map((e) => TrackModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ListTrackModelToJson(ListTrackModel instance) =>
    <String, dynamic>{
      'tracks': instance.tracks,
    };
