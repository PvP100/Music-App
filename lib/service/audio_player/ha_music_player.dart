import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_app/core/core.dart';

class HaMusicPlayer {
  late final AudioPlayer _audioPlayer;

  late final StreamController<double> _positionController;

  late final StreamController<bool> _playController;

  final List<Song> songs = [];

  late final List<StreamController> _streamControllers;

  bool isSeeking = false;

  HaMusicPlayer._();

  static final HaMusicPlayer _instance = HaMusicPlayer._();

  static HaMusicPlayer get instance => _instance;

  Future<void> initAudio() async {
    _audioPlayer = AudioPlayer();
    _positionController = StreamController<double>.broadcast();

    _playController = StreamController<bool>.broadcast();

    _audioPlayer.positionStream.listen((event) {
      if (songs.isNotEmpty && !isSeeking) {
        double percent = event.inMilliseconds /
            songs[_audioPlayer.currentIndex ?? 0].duration;
        _positionController.add(percent);
      }
    });

    _audioPlayer.positionStream.listen((event) {});
    _audioPlayer.currentIndexStream.listen((event) {});
    _audioPlayer.playerStateStream.listen((event) async {
      switch (event.processingState) {
        case ProcessingState.completed:
          {
            if (event.playing) {
              await _audioPlayer.seek(0.milliseconds);
              _audioPlayer.pause();
            }
            break;
          }
        default:
          {
            break;
          }
      }
      _playController.add(event.playing);
    });
    _audioPlayer.playbackEventStream.listen((event) {});

    _streamControllers = [
      _positionController,
      _playController,
    ];
    return;
  }

  Future<void> setPlaylist(List<Song> songs) async {
    this.songs.clear();
    this.songs.addAll(songs);
    List<AudioSource> audioSource =
        songs.map((e) => AudioSource.uri(Uri.parse(e.url))).toList();
    final playlist = ConcatenatingAudioSource(
      children: audioSource,
      shuffleOrder: DefaultShuffleOrder(),
    );
    await _audioPlayer.setAudioSource(
      playlist,
      initialIndex: 0,
      initialPosition: 0.milliseconds,
    );
  }

  Future<void> play() async {
    await _audioPlayer.play();
  }

  Future<void> pause() async {
    await _audioPlayer.pause();
  }

  Future<void> stop() async {
    await _audioPlayer.stop();
  }

  Future<void> seek(Duration duration, {int? index}) async {
    await _audioPlayer.seek(duration, index: index);
  }

  Future<void> seekToNext() async {
    await _audioPlayer.seekToNext();
  }

  Future<void> seekToPrevious() async {
    await _audioPlayer.seekToPrevious();
  }

  Future<void> dispose() async {
    _audioPlayer.dispose();
    for (var element in _streamControllers) {
      element.close();
    }
  }

  Future<void> setShuffle() async {
    await _audioPlayer.setShuffleModeEnabled(!_audioPlayer.shuffleModeEnabled);
  }

  Future<void> setLoop(LoopMode mode) async {
    await _audioPlayer.setLoopMode(mode);
  }

  Stream<double> get percentChanged => _positionController.stream;

  Stream<bool> get shuffleChanged => _audioPlayer.shuffleModeEnabledStream;

  Stream<bool> get playChanged => _playController.stream;

  StreamController<double> get percentChangedController => _positionController;

  Duration get currentPosition => _audioPlayer.position;

  Stream<int?> get currentIndexChanged => _audioPlayer.currentIndexStream;

  Stream<PlaybackEvent> get playbackEventStream =>
      _audioPlayer.playbackEventStream;

  bool get isPlaying => _audioPlayer.playing;

  AudioPlayer get audioPlayer => _audioPlayer;

  /// Transform a just_audio event into an audio_service state.
  ///
  /// This method is used from the constructor. Every event received from the
  /// just_audio player will be transformed into an audio_service state so that
  /// it can be broadcast to audio_service clients.
  PlaybackState transformEvent(PlaybackEvent event) {
    return PlaybackState(
      controls: [
        MediaControl.skipToPrevious,
        MediaControl.skipToNext,
        MediaControl.rewind,
        if (_audioPlayer.playing) MediaControl.pause else MediaControl.play,
      ],
      systemActions: const {
        MediaAction.seek,
        MediaAction.seekForward,
        MediaAction.seekBackward,
      },
      androidCompactActionIndices: const [0, 1, 3],
      processingState: const {
        ProcessingState.idle: AudioProcessingState.idle,
        ProcessingState.loading: AudioProcessingState.loading,
        ProcessingState.buffering: AudioProcessingState.buffering,
        ProcessingState.ready: AudioProcessingState.ready,
        ProcessingState.completed: AudioProcessingState.completed,
      }[_audioPlayer.processingState]!,
      playing: _audioPlayer.playing,
      updatePosition: _audioPlayer.position,
      bufferedPosition: _audioPlayer.bufferedPosition,
      speed: _audioPlayer.speed,
      queueIndex: event.currentIndex,
    );
  }
}

class Song {
  final String id;
  final String url;
  final String name;
  final int duration;

  Song({
    required this.url,
    required this.name,
    required this.duration,
    required this.id,
  });
}
