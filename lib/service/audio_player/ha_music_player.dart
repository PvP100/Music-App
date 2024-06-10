import 'dart:async';

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

  Future<void> seek(Duration duration) async {
    await _audioPlayer.seek(duration);
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

  bool get isPlaying => _audioPlayer.playing;
}

class Song {
  final String id;
  final String url;
  final int duration;

  Song({required this.url, required this.duration, required this.id});
}
