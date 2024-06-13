import 'package:audio_service/audio_service.dart';
import 'package:music_app/service/audio_player/ha_music_player.dart';

class AppAudioServices extends BaseAudioHandler {
  // static final _item = MediaItem(
  //   id: 'https://s3.amazonaws.com/scifri-episodes/scifri20181123-episode.mp3',
  //   album: "Science Friday",
  //   title: "A Salute To Head-Scratching Science",
  //   artist: "Science Friday and WNYC Studios",
  //   duration: const Duration(milliseconds: 5739820),
  //   artUri: Uri.parse(
  //       'https://media.wnyc.org/i/1400/1400/l/80/1/ScienceFriday_WNYCStudios_1400.jpg'),
  // );

  final HaMusicPlayer _player = HaMusicPlayer.instance;

  /// Initialise our audio handler.
  AppAudioServices() {
    _player.initAudio();

    // So that our clients (the Flutter UI and the system notification) know
    // what state to display, here we set up our audio handler to broadcast all
    // playback state changes as they happen via playbackState...
    _player.playbackEventStream.map(_player.transformEvent).pipe(playbackState);

    _player.currentIndexChanged.listen((event) {
      if (queue.value.isNotEmpty) {
        mediaItem.add(queue.value[event ?? 0]);
      }
    });
  }

  // In this simple example, we handle only 4 actions: play, pause, seek and
  // stop. Any button press from the Flutter UI, notification, lock screen or
  // headset will be routed through to these 4 methods so that you can handle
  // your audio playback logic in one place.

  @override
  Future<void> play() => _player.play();

  @override
  Future<void> pause() => _player.pause();

  @override
  Future<void> seek(Duration position) => _player.seek(position);

  @override
  Future<void> stop() => _player.stop();

  @override
  Future<void> skipToNext() => _player.seekToNext();

  @override
  Future<void> skipToPrevious() => _player.seekToPrevious(true);

  @override
  Future<void> addQueueItems(List<MediaItem> mediaItems) async {
    queue.add(mediaItems);
    return _player.setPlaylist(mediaItems
        .map(
          (e) => Song(
            url: e.id,
            name: e.artist ?? "",
            duration: e.duration?.inMilliseconds ?? 0,
            id: e.id,
          ),
        )
        .toList());
  }

  void dispose() {
    _player.dispose();
  }

  HaMusicPlayer get player => _player;
}
