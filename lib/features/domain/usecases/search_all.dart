import 'package:music_app/features/data/base/result.dart';
import 'package:music_app/features/domain/entities/enum/search_type.dart';
import 'package:music_app/features/domain/repositories/hamusic_repository.dart';
import 'package:music_app/features/domain/usecases/use_case.dart';

import '../entities/search_entity.dart';

class SearchAll extends UseCase<List<SearchEntity>, Map<String, SearchType>> {
  final HamusicRepository _repository;

  SearchAll(this._repository);

  @override
  Future<Result<List<SearchEntity>>> run(Map<String, SearchType> params) async {
    return switch (params.values.first) {
      SearchType.album =>
        (await _repository.getListAlbum(params.entries.first.key)).convert(
          (data) => data?.data
              ?.map(
                (e) => SearchEntity(
                  name: e.name,
                  id: e.id,
                  image: e.thumbnail,
                  type: TrackType.album,
                  artist: e.singers?.map((e) => e.data?.name).join(", "),
                ),
              )
              .toList(),
        ),
      SearchType.song =>
        (await _repository.getTrack(params.entries.first.key)).convert(
          (data) => data?.data
              ?.map(
                (e) => SearchEntity(
                  name: e.name,
                  id: e.id,
                  image: e.fileId,
                  type: TrackType.song,
                  artist: e.singers?.map((e) => e.data?.name).join(", "),
                ),
              )
              .toList(),
        ),
      SearchType.playlist =>
        (await _repository.getListPlaylist(params.entries.first.key)).convert(
          (data) => data?.data
              ?.map(
                (e) => SearchEntity(
                  name: e.name,
                  id: e.id,
                  image: e.thumbnail,
                  type: TrackType.playlist,
                  artist: e.singers?.map((e) => e.data?.name).join(", "),
                ),
              )
              .toList(),
        ),
      SearchType.artist =>
        (await _repository.getListArtist(params.entries.first.key)).convert(
          (data) => data?.data
              ?.map(
                (e) => SearchEntity(
                  name: e.name,
                  id: e.id,
                  image: e.thumbnail,
                  type: TrackType.artist,
                ),
              )
              .toList(),
        ),
      _ =>
        (await _repository.searchAll(params.entries.first.key)).convert((data) {
          List<SearchEntity> mapData = [];
          mapData.addAll((data?.data?.singers ?? []).map((e) => SearchEntity(
                name: e.name,
                id: e.id,
                image: e.thumbnail,
                type: TrackType.artist,
              )));
          mapData.addAll((data?.data?.songs ?? []).map((e) => SearchEntity(
                name: e.name,
                id: e.id,
                image: e.thumbnail,
                artist: e.singers?.map((e) => e.data?.name ?? "").join(", "),
                type: TrackType.song,
              )));
          mapData.addAll((data?.data?.album ?? []).map((e) => SearchEntity(
                name: e.name,
                id: e.id,
                image: e.thumbnail,
                artist: e.singers?.map((e) => e.data?.name).join(", "),
                type: TrackType.album,
              )));
          mapData.addAll((data?.data?.playlist ?? []).map((e) => SearchEntity(
                name: e.name,
                id: e.id,
                image: e.thumbnail,
                artist: e.singers?.map((e) => e.data?.name).join(", "),
                type: TrackType.playlist,
              )));
          return mapData;
        })
    };
  }
}
