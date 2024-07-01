import 'package:music_app/features/domain/entities/search_entity.dart';

class LikeRequest {
  final String id;
  final String userId;
  final TrackType type;

  LikeRequest({required this.id, required this.userId, required this.type});
}
