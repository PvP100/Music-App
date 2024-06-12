import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:music_app/core/core.dart';
import 'package:music_app/features/data/base/result.dart';
import 'package:music_app/features/data/models/list_track/list_track_model.dart';
import 'package:music_app/features/domain/repositories/hamusic_repository.dart';
import 'package:music_app/features/domain/usecases/use_case.dart';

class GetTrack extends UseCase<ListTrackModel, String> {
  final HamusicRepository _hamusicRepository;

  GetTrack(this._hamusicRepository);

  @override
  Future<Result<ListTrackModel>> run(String params) async {
    String data = await rootBundle.loadString("assets/json/track.json");
    await Future.delayed(0.milliseconds);
    return Result.success(ListTrackModel.fromJson(jsonDecode(data)));
    // return _hamusicRepository.getTrack(params);
  }
}
