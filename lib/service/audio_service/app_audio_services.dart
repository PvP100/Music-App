import 'package:audio_service/audio_service.dart';

class AppAudioServices extends BaseAudioHandler {
  @override
  Future<void> play() async {
    print("3234234");
  }

  @override
  Future<void> pause() async {
    print("3234234");
  }

  @override
  Future<void> click([MediaButton button = MediaButton.media]) async {
    print("3247329423");
  }
}
