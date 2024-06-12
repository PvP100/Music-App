import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_app/core/constants/image_constants.dart';
import 'package:music_app/core/core.dart';
import 'package:music_app/features/data/models/track/track_model.dart';
import 'package:music_app/features/domain/entities/object_list_entity.dart';
import 'package:music_app/features/presentation/blocs/main/main_bloc.dart';
import 'package:music_app/features/presentation/ui/screen/main/widget/bottom_bar_widget.dart';
import 'package:music_app/features/presentation/ui/screen/track/widget/mini_play_widget.dart';
import 'package:music_app/features/presentation/ui/screen/track/widget/play_widget.dart';
import 'package:music_app/service/audio_player/ha_music_player.dart';
import 'package:music_app/service/audio_service/app_audio_services.dart';

import 'widget/track_image_widget.dart';

class TrackScreen extends StatefulWidget {
  const TrackScreen(
      {super.key, required this.onClose, required this.animationController});

  final VoidCallback onClose;

  final AnimationController animationController;

  @override
  State<TrackScreen> createState() => _TrackScreenState();
}

class _TrackScreenState extends State<TrackScreen> {
  List<PageController> pageControllers = [];

  late final PageController _controller;

  late final PageController _miniController;

  final ValueNotifier<double> _volumeLevelNotifier = ValueNotifier(0);

  final AppAudioServices _audioService = GetIt.I.get<AppAudioServices>();

  late final HaMusicPlayer _player;

  late final Duration pageDuration;

  bool isMiniScroll = false;

  bool isBiggerPlayerScroll = false;

  late final MainBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = context.read<MainBloc>();
    _player = _audioService.player;
    pageDuration = 500.milliseconds;
    _controller = PageController();
    _miniController = PageController();
    _player.currentIndexChanged.listen((event) {
      if (event != null && _controller.hasClients) {
        _controller.animateToPage(
          event,
          duration: pageDuration,
          curve: Curves.decelerate,
        );
      }
    });
  }

  @override
  void dispose() {
    _volumeLevelNotifier.dispose();
    _miniController.dispose();
    _controller.dispose();
    super.dispose();
  }

  _stateListener(BuildContext context, MainState state) {
    if (state.trackState?.isRefresh == true) {
      List<TrackModel> tracks = (state.trackState?.track?.models ?? []);
      _audioService.addQueueItems(tracks
          .map((e) => MediaItem(
                id: e.previewUrl ?? "",
                title: e.album?.name ?? "",
                duration: (e.durationMs ?? 0).milliseconds,
                artist: e.album?.artists?.map((e) => e.name).join(", "),
                artUri: Uri.parse(e.album?.images?.firstOrNull?.url ?? ""),
              ))
          .toList());
      _audioService.play();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MainBloc, MainState>(
      listener: _stateListener,
      child: Stack(
        children: [
          AnimatedBuilder(
              animation: widget.animationController,
              child: Container(
                color: AppColors.primaryBackgroundColor,
                child: BlocSelector<MainBloc, MainState,
                        ObjectListEntity<TrackModel>?>(
                    selector: (state) => state.trackState?.track,
                    builder: (context, track) {
                      return NotificationListener(
                        onNotification: (notification) {
                          if (notification is UserScrollNotification) {
                            _miniController
                                .jumpToPage(_controller.page?.toInt() ?? 0);
                          }
                          return false;
                        },
                        child: PageView.builder(
                          physics: const ClampingScrollPhysics(),
                          controller: _controller,
                          onPageChanged: _onPageChanged,
                          itemBuilder: (context, index) => TrackImageWidget(
                            model: track?.models[index],
                          ),
                          itemCount: track?.models.length ?? 0,
                        ),
                      );
                    }),
              ),
              builder: (context, child) {
                double offset = widget.animationController.value;
                double newOffset = offset > 0.05 ? 0 : 1 - offset * 20;
                return Positioned.fill(
                  child: Opacity(
                    opacity: 1 - newOffset,
                    child: child,
                  ),
                );
              }),
          Positioned.fill(
              child: IgnorePointer(
            child: Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0x00000000),
                Color(0xFF000000),
              ],
            ))),
          )),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: BlocBuilder<MainBloc, MainState>(
                buildWhen: (previous, current) =>
                    previous.trackState?.currentIndex !=
                    current.trackState?.currentIndex,
                builder: (context, state) {
                  TrackModel? model = state.trackState?.track
                      ?.models[state.trackState?.currentIndex ?? 0];
                  return PlayWidget(
                    track: model,
                    onPlay: _onPlay,
                    onChangeDuration: _durationChanged,
                    volumeNotifier: _volumeLevelNotifier,
                    volumeChanged: _volumeChanged,
                    onPrevious: _onPrevious,
                    onNext: _onNext,
                    onShuffle: _player.setShuffle,
                    onLoopChange: _loop,
                  );
                }),
          ),
          Positioned(
              top: 15 + context.statusBarHeight,
              right: 19,
              child: AnimatedBuilder(
                  animation: widget.animationController,
                  child: Container(
                    height: 36,
                    width: 36,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.colorBlackWith25,
                    ),
                    alignment: Alignment.center,
                    child: ImageConstants.iconArrowDown
                        .loadImageAsset(height: 26, width: 26),
                  ).onCupertinoClick(widget.onClose),
                  builder: (context, child) {
                    return Opacity(
                      opacity: widget.animationController.value,
                      child: child,
                    );
                  })),
          AnimatedBuilder(
              animation: widget.animationController,
              child: const BottomBarWidget(),
              builder: (context, child) {
                return Positioned(
                  top: (context.bottomBarHeight + context.height) *
                      widget.animationController.value,
                  left: 0,
                  right: 0,
                  child: child!,
                );
              }),
          BlocBuilder<MainBloc, MainState>(
            buildWhen: (previous, current) =>
                previous.trackState?.currentIndex !=
                current.trackState?.currentIndex,
            builder: (context, state) {
              TrackModel? model = state.trackState?.track
                  ?.models[state.trackState?.currentIndex ?? 0];
              return AnimatedBuilder(
                  animation: widget.animationController,
                  child: NotificationListener(
                    onNotification: (notification) {
                      if (notification is UserScrollNotification) {
                        _controller
                            .jumpToPage(_miniController.page?.toInt() ?? 0);
                      }
                      return false;
                    },
                    child: MiniPlayWidget(
                      controller: _miniController,
                      trackModel: model,
                    ),
                  ),
                  builder: (context, child) {
                    double offset = widget.animationController.value;
                    double newOffset = offset > 0.05 ? 0 : 1 - offset * 20;
                    return Opacity(
                      opacity: newOffset,
                      child: child,
                    );
                  });
            },
          ),
        ],
      ),
    );
  }

  _onNext() {
    _player.seekToNext();
  }

  _onPrevious() {
    _player.seekToPrevious();
  }

  _durationChanged(Duration duration) {
    _player.seek(duration);
  }

  _onPlay() {
    _player.isPlaying ? _player.pause() : _player.play();
  }

  _volumeChanged(double value) {}

  _onPageChanged(int index) async {
    int oldIndex = bloc.state.trackState?.currentIndex ?? 0;
    bloc.changeTrack(index);
    if (oldIndex < index) {
      await _player.seekToNext();
    } else {
      await _player.seekToPrevious(false);
    }
    if (!_player.isPlaying) {
      _player.play();
    }
  }

  _loop(LoopMode mode) {
    _player.setLoop(mode);
  }
}
