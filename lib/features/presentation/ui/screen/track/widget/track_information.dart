import 'package:flutter/material.dart';

import '../../../../../../core/constants/image_constants.dart';
import '../../../../../../core/core.dart';

class TrackInformation extends StatelessWidget {
  const TrackInformation(
      {super.key, required this.trackName, required this.trackArtists});

  final String trackName;

  final String trackArtists;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              trackName,
              style: AppTextStyles.bold.copyWith(fontSize: 24),
            ),
            Text(
              trackArtists,
              style: AppTextStyles.medium
                  .copyWith(fontSize: 20, color: AppColors.colorF2F2F2With75),
            ),
          ],
        ).expanded(),
        Container(
            height: 24,
            width: 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.colorD9D9D9.withOpacity(0.6),
            ),
            alignment: Alignment.center,
            child: ImageConstants.iconThreeDot
                .loadImageAsset(height: 20, width: 20))
      ],
    );
  }
}
