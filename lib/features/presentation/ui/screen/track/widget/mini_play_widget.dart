import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/core/core.dart';
import 'package:music_app/features/data/models/track/track_model.dart';
import 'package:music_app/features/presentation/blocs/blocs.dart';

import '../../../../../../core/constants/image_constants.dart';
import '../../../../../../service/audio_player/ha_music_player.dart';
import '../../../../../domain/entities/object_list_entity.dart';
import 'enable_button_widget.dart';
import 'slider_widget.dart';

class MiniPlayWidget extends StatelessWidget {
  const MiniPlayWidget({
    super.key,
    required this.trackModel,
    required this.controller,
  });

  final TrackModel? trackModel;

  final PageController controller;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AppBloc, AppState, bool>(
      selector: (state) => state.playState?.showMiniPlayer ?? false,
      builder: (context, v) {
        return Visibility(
          visible: v,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Stack(
              children: [
                SizedBox(
                  height: 60,
                  child: Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(7),
                        height: 46,
                        width: 46,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child:
                            trackModel?.thumbnailId.filePathUrl().loadImageUrl(
                                  placeHolder: ImageConstants.musicPlaceholder
                                      .loadImageAsset(),
                                  errorWidget: ImageConstants.musicPlaceholder
                                      .loadImageAsset(),
                                ),
                      ),
                      BlocSelector<MainBloc, MainState,
                          ObjectListEntity<TrackModel>?>(
                        selector: (state) => state.trackState?.track,
                        builder: (context, v) {
                          return PageView.builder(
                              itemCount: v?.models.length ?? 0,
                              controller: controller,
                              itemBuilder: (context, index) {
                                TrackModel? track = v?.models[index];
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      track?.name ?? "",
                                      style: AppTextStyles.medium
                                          .copyWith(fontSize: 13),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      (track?.singers ?? [])
                                          .map((e) => e.data?.name ?? "")
                                          .join(", "),
                                      style: AppTextStyles.medium.copyWith(
                                        fontSize: 12,
                                        color: AppColors.colorA3A3A3,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                );
                              });
                        },
                      ).expanded(),
                      StreamBuilder(
                          stream: HaMusicPlayer.instance.playChanged,
                          builder: (context, snapshot) {
                            return EnableButtonWidget(
                              onChanged: _onPlay,
                              size: 32,
                              enableWidget: ImageConstants.iconPause,
                              disableWidget: ImageConstants.iconPlay,
                              enable: snapshot.data ?? false,
                            );
                          }).paddingOnly(right: 7),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 8,
                  right: 8,
                  child: StreamBuilder<double>(
                      stream: HaMusicPlayer.instance.percentChanged,
                      builder: (context, snapshot) {
                        return SliderWidget(
                          height: 2,
                          sliderValue: snapshot.data ?? 0,
                          onChanged: (_) {},
                          onChangedEnd: (_) {},
                        );
                      }),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  _onPlay() {
    HaMusicPlayer player = HaMusicPlayer.instance;
    player.isPlaying ? player.pause() : player.play();
  }
}
