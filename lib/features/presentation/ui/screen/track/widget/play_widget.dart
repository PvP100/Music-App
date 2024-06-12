import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_app/core/constants/image_constants.dart';
import 'package:music_app/core/core.dart';
import 'package:music_app/features/data/models/track/track_model.dart';
import 'package:music_app/features/presentation/ui/screen/track/widget/loop_widget.dart';
import 'package:music_app/service/audio_player/ha_music_player.dart';

import 'enable_button_widget.dart';
import 'slider_widget.dart';
import 'track_information.dart';
import 'track_time_widget.dart';

class PlayWidget extends StatelessWidget {
  const PlayWidget({
    super.key,
    this.track,
    required this.volumeNotifier,
    required this.volumeChanged,
    required this.onChangeDuration,
    required this.onPlay,
    required this.onNext,
    required this.onPrevious,
    required this.onShuffle,
    required this.onLoopChange,
  });

  final TrackModel? track;

  final ValueNotifier<double> volumeNotifier;

  final ValueChanged<double> volumeChanged;

  final ValueChanged<Duration> onChangeDuration;

  final VoidCallback onPlay;

  final VoidCallback onNext;

  final VoidCallback onPrevious;

  final VoidCallback onShuffle;

  final ValueChanged<LoopMode> onLoopChange;

  _onChanged(double v) {
    HaMusicPlayer.instance.isSeeking = false;
    Duration duration = ((track?.durationMs ?? 0) * v).milliseconds;
    onChangeDuration(duration);
  }

  @override
  Widget build(BuildContext context) {
    final artists =
        (track?.album?.artists?.map((e) => e.name) ?? []).join(", ");
    return Container(
      color: Colors.transparent,
      child: Column(
        children: [
          TrackInformation(
            trackName: track?.album?.name ?? "",
            trackArtists: artists,
          ).paddingSymmetric(horizontal: 24),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 30, 24, 0),
            child: StreamBuilder<double>(
                stream: HaMusicPlayer.instance.percentChanged,
                builder: (context, snapshot) {
                  return SliderWidget(
                    sliderValue: snapshot.data ?? 0,
                    onChanged: (v) {
                      HaMusicPlayer.instance.isSeeking = true;
                      HaMusicPlayer.instance.percentChangedController.add(v);
                    },
                    onChangedEnd: _onChanged,
                  );
                }),
          ),
          ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 15.0,
                sigmaY: 15.0,
              ),
              child: Container(
                decoration: const BoxDecoration(color: Color(0x03000000)),
                padding: EdgeInsets.fromLTRB(
                    24, 16, 24, context.safeAreaBottomHeight + 15),
                child: Column(
                  children: [
                    StreamBuilder(
                        stream: HaMusicPlayer.instance.percentChanged,
                        builder: (context, builder) {
                          int total = track?.durationMs ?? 0;
                          int current = ((builder.data ?? 0) * total).toInt();
                          return TrackTimeWidget(
                            currentTimeMs: current,
                            totalMs: total - current,
                          );
                        }),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        StreamBuilder(
                            stream: HaMusicPlayer.instance.shuffleChanged,
                            builder: (context, builder) {
                              return EnableButtonWidget(
                                onChanged: onShuffle,
                                size: 32,
                                enableWidget: ImageConstants.iconShuffleOn,
                                disableWidget: ImageConstants.iconShuffle,
                                enable: builder.data ?? false,
                              );
                            }),
                        ImageConstants.iconPrevious
                            .loadImageAsset(height: 32, width: 46)
                            .onCupertinoClick(onPrevious),
                        StreamBuilder(
                            stream: HaMusicPlayer.instance.playChanged,
                            builder: (context, snapshot) {
                              return EnableButtonWidget(
                                onChanged: onPlay,
                                size: 56,
                                enableWidget: ImageConstants.iconPause,
                                disableWidget: ImageConstants.iconPlay,
                                enable: snapshot.data ?? false,
                              );
                            }),
                        ImageConstants.iconNext
                            .loadImageAsset(height: 32, width: 46)
                            .onCupertinoClick(onNext),
                        LoopWidget(onLoopChange: onLoopChange),
                      ],
                    ).paddingOnly(top: 27),
                    Row(
                      children: [
                        ImageConstants.iconVolumeDown
                            .loadImageAsset(height: 18, width: 18),
                        SliderWidget(
                          sliderValue: 0.5,
                          onChanged: volumeChanged,
                          onChangedEnd: (_) {},
                        ).paddingSymmetric(horizontal: 15).expanded(),
                        ImageConstants.iconVolumeUp
                            .loadImageAsset(height: 18, width: 18),
                      ],
                    ).paddingOnly(bottom: 24, top: 50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ImageConstants.iconLyric
                            .loadImageAsset(height: 24, width: 24),
                        ImageConstants.iconAudioOutput
                            .loadImageAsset(height: 24, width: 24),
                        ImageConstants.iconListTrack
                            .loadImageAsset(height: 24, width: 24),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
