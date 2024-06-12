import 'package:audio_service/audio_service.dart';
import 'package:get_it/get_it.dart';
import 'package:music_app/service/audio_service/app_audio_services.dart';

class AudioDi {
  AudioDi._();

  static Future<void> init(GetIt injector) async {
    injector
        .registerSingletonAsync<AppAudioServices>(() async => AudioService.init(
            builder: () => AppAudioServices(),
            config: const AudioServiceConfig(
              androidNotificationChannelId:
                  'com.phongpv.music_app.channel.audio',
              androidNotificationChannelName: 'Music playback',
              androidNotificationOngoing: true,
            )));
  }
}
