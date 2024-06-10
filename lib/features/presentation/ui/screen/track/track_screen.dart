import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_app/core/constants/image_constants.dart';
import 'package:music_app/core/core.dart';
import 'package:music_app/features/data/models/track/track_model.dart';
import 'package:music_app/features/domain/entities/object_list_entity.dart';
import 'package:music_app/features/presentation/blocs/track/track_bloc.dart';
import 'package:music_app/features/presentation/ui/screen/base_screen_state.dart';
import 'package:music_app/features/presentation/ui/screen/main/widget/bottom_bar_widget.dart';
import 'package:music_app/features/presentation/ui/screen/track/widget/mini_play_widget.dart';
import 'package:music_app/features/presentation/ui/screen/track/widget/play_widget.dart';
import 'package:music_app/service/audio_player/ha_music_player.dart';
import 'package:real_volume/real_volume.dart';

import 'widget/track_image_widget.dart';

class TrackScreen extends StatefulWidget {
  const TrackScreen(
      {super.key, required this.onClose, required this.animationController});

  final VoidCallback onClose;

  final AnimationController animationController;

  @override
  State<TrackScreen> createState() => _TrackScreenState();
}

class _TrackScreenState
    extends BaseScreenState<TrackScreen, TrackBloc, TrackState> {
  @override
  bool get safeAreaBottom => false;

  @override
  bool get safeAreaTop => false;

  late final PageController _controller;

  final ValueNotifier<double> _volumeLevelNotifier = ValueNotifier(0);

  final HaMusicPlayer _player = HaMusicPlayer.instance;

  late final Duration pageDuration;

  @override
  void initState() {
    super.initState();
    pageDuration = 500.milliseconds;
    _controller = PageController();
    RealVolume.onVolumeChanged.listen((event) async {});
    _player.currentIndexChanged.listen((event) {
      if (event != null) {
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
    _controller.dispose();
    super.dispose();
  }

  @override
  void onStateListener(BuildContext context, TrackState state) {
    super.onStateListener(context, state);
    if (state.isRefresh) {
      List<TrackModel> tracks = (state.track?.models ?? []);
      _player.setPlaylist(
        tracks
            .map(
              (e) => Song(
                url: e.previewUrl ?? "",
                duration: e.durationMs ?? 0,
                id: "",
              ),
            )
            .toList(),
      );
    }
  }

  @override
  Color get backgroundColor => Colors.transparent;

  @override
  Widget buildContent(BuildContext context) {
    return Stack(
      children: [
        AnimatedBuilder(
            animation: widget.animationController,
            child: BlocSelector<TrackBloc, TrackState,
                    ObjectListEntity<TrackModel>?>(
                selector: (state) => state.track,
                builder: (context, track) {
                  return PageView.builder(
                    controller: _controller,
                    onPageChanged: _onPageChanged,
                    itemBuilder: (context, index) => TrackImageWidget(
                      model: track?.models[index],
                    ),
                    itemCount: track?.models.length ?? 0,
                  );
                }),
            builder: (context, child) {
              return Positioned.fill(
                child: Opacity(
                  opacity: widget.animationController.value,
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
          child: BlocBuilder<TrackBloc, TrackState>(
              buildWhen: (previous, current) =>
                  previous.currentIndex != current.currentIndex,
              builder: (context, state) {
                TrackModel? model =
                    state.track?.models[state.currentIndex ?? 0];
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
            ).onCupertinoClick(widget.onClose)),
        AnimatedBuilder(
            animation: widget.animationController,
            child: const BottomBarWidget(),
            builder: (context, child) {
              return Positioned(
                top: (context.bottomBarHeight +
                        AppConstants.musicPlayHeight / 2 +
                        context.height) *
                    widget.animationController.value,
                left: 0,
                right: 0,
                child: child!,
              );
            }),
        Positioned(
            child: MiniPlayWidget(
          controller: _controller,
          trackModel: bloc.state.track?.models[0],
        )),
      ],
    );
  }

  _onNext() {
    int page = (_controller.page?.toInt() ?? 0) + 1;
    if (page < (bloc.state.track?.models.length ?? 0)) {
      _controller.animateToPage(
        page,
        duration: pageDuration,
        curve: Curves.decelerate,
      );
    }
  }

  _onPrevious() {
    if (_player.currentPosition.inSeconds >= 3) {
      _player.seek(0.milliseconds);
    } else {
      int page = (_controller.page?.toInt() ?? 0) - 1;
      if (page >= 0) {
        _controller.animateToPage(
          page,
          duration: pageDuration,
          curve: Curves.decelerate,
        );
      }
    }
  }

  _durationChanged(Duration duration) {
    _player.seek(duration);
  }

  _onPlay() {
    _player.isPlaying ? _player.pause() : _player.play();
  }

  _volumeChanged(double value) {
    RealVolume.setVolume(value);
  }

  _onPageChanged(int index) async {
    int oldIndex = bloc.state.currentIndex ?? 0;
    bloc.changeTrack(index);
    if (oldIndex < index) {
      await _player.seekToNext();
    } else {
      await _player.seekToPrevious();
    }
    if (!_player.isPlaying) {
      _player.play();
    }
  }

  _loop(LoopMode mode) {
    _player.setLoop(mode);
  }
}
