import 'package:flutter/material.dart';
import 'package:music_app/core/core.dart';

import '../../../../../data/models/track/track_model.dart';

class TrackImageWidget extends StatelessWidget {
  const TrackImageWidget({super.key, this.model});

  final TrackModel? model;

  @override
  Widget build(BuildContext context) {
    return OverflowBox(
      alignment: Alignment.topCenter,
      maxHeight: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AspectRatio(
            aspectRatio: 2 / 3,
            child: model?.thumbnailId.filePathUrl().loadImageUrl(),
          ),
          AspectRatio(
            aspectRatio: 2 / 3,
            child: Transform.flip(
              flipY: true,
              child: model?.thumbnailId.filePathUrl().loadImageUrl(),
            ),
          )
        ],
      ),
    );
  }
}
