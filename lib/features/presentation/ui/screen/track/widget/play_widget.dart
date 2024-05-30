import 'package:flutter/material.dart';
import 'package:music_app/core/constants/image_constants.dart';
import 'package:music_app/core/core.dart';
import 'package:music_app/features/data/models/track/track_model.dart';

import 'slider_widget.dart';
import 'track_information.dart';

class PlayWidget extends StatelessWidget {
  const PlayWidget({super.key, this.track});

  final TrackModel? track;

  @override
  Widget build(BuildContext context) {
    final artists =
        (track?.album?.artists?.map((e) => e.name) ?? []).join(", ");
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0x00000000),
          Color(0xFF000000),
        ],
      )),
      child: Column(
        children: [
          TrackInformation(
            trackName: track?.album?.name ?? "",
            trackArtists: artists,
          ).paddingSymmetric(horizontal: 24),
          const Padding(
            padding: EdgeInsets.fromLTRB(24, 30, 24, 0),
            child: SliderWidget(),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(
                24, 16, 24, context.safeAreaBottomHeight + 15),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "0:00",
                      style: AppTextStyles.medium.copyWith(fontSize: 14),
                    ),
                    Text(
                      "0:00",
                      style: AppTextStyles.medium.copyWith(fontSize: 14),
                    )
                  ],
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
                    const SliderWidget()
                        .paddingSymmetric(horizontal: 15)
                        .expanded(),
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
          )
        ],
      ),
    );
  }
}
