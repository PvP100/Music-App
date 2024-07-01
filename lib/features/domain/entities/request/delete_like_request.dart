import 'package:music_app/features/domain/entities/search_entity.dart';

class DeleteLikeRequest {
  final int id;

  final TrackType type;

  DeleteLikeRequest({required this.id, required this.type});
}
