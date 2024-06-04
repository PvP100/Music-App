import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:music_app/core/constants/image_constants.dart';
import 'package:music_app/core/core.dart';
import 'package:music_app/features/data/models/track/track_model.dart';

import 'slider_widget.dart';
import 'track_information.dart';
import 'track_time_widget.dart';

class PlayWidget extends StatelessWidget {
  const PlayWidget({
    super.key,
    this.track,
    required this.trackNotifier,
    required this.volumeNotifier,
    required this.volumeChanged,
  });

  final TrackModel? track;

  final ValueNotifier<double> trackNotifier;

  final ValueNotifier<double> volumeNotifier;

  final ValueChanged<double> volumeChanged;

  @override
  Widget build(BuildContext context) {
    final artists =
        (track?.album?.artists?.map((e) => e.name) ?? []).join(", ");
    return Column(
      children: [
        TrackInformation(
          trackName: track?.album?.name ?? "",
          trackArtists: artists,
        ).paddingSymmetric(horizontal: 24),
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 30, 24, 0),
          child: SliderWidget(
            sliderValue: trackNotifier,
            onChanged: (v) {},
          ),
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
                  TrackTimeWidget(
                    currentTimeMs: 0,
                    totalMs: track?.durationMs ?? 0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ImageConstants.iconShuffle
                          .loadImageAsset(height: 32, width: 32),
                      ImageConstants.iconPrevious
                          .loadImageAsset(height: 32, width: 46),
                      ImageConstants.iconPlay
                          .loadImageAsset(height: 56, width: 56),
                      ImageConstants.iconNext
                          .loadImageAsset(height: 32, width: 46),
                      ImageConstants.iconRepeat
                          .loadImageAsset(height: 32, width: 32),
                    ],
                  ).paddingOnly(top: 27),
                  Row(
                    children: [
                      ImageConstants.iconVolumeDown
                          .loadImageAsset(height: 18, width: 18),
                      SliderWidget(
                        sliderValue: volumeNotifier,
                        onChanged: volumeChanged,
                      ).paddingSymmetric(horizontal: 15).expanded(),
                      ImageConstants.iconVolumeUp
                          .loadImageAsset(height: 18, width: 18),
                    ],
                  ).paddingOnly(bottom: 24, top: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ImageConstants.iconListTrack
                          .loadImageAsset(height: 24, width: 24),
                      ImageConstants.iconListTrack
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
    );
  }
}
