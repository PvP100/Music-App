import 'package:flutter/material.dart';

import '../../../../../../core/core.dart';

class TrackInformation extends StatelessWidget {
  const TrackInformation({
    super.key,
    required this.trackName,
    required this.trackArtists,
    required this.isLiked,
    required this.onFavorite,
  });

  final String trackName;

  final String trackArtists;

  final bool isLiked;

  final VoidCallback onFavorite;

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
        Icon(
          isLiked ? Icons.check_circle : Icons.add_circle_outline,
          color: isLiked ? AppColors.primary : Colors.white,
          size: 32,
        ).onCupertinoClick(onFavorite),
      ],
    );
  }
}
