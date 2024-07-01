import 'package:flutter/material.dart';
import 'package:music_app/core/constants/image_constants.dart';
import 'package:music_app/core/core.dart';

class AlbumHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double appBarHeight;

  final String? name;

  final String? image;

  final ValueChanged<bool> onPlay;

  final VoidCallback favorite;

  final bool isLiked;

  AlbumHeaderDelegate({
    required this.appBarHeight,
    this.name,
    this.image,
    required this.favorite,
    required this.onPlay,
    this.isLiked = false,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    double percent = (shrinkOffset > (maxExtent - appBarHeight)
            ? (maxExtent - appBarHeight)
            : shrinkOffset) /
        (maxExtent - appBarHeight);
    double offset = 1 - percent;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          height: appBarHeight,
          color: AppColors.primaryBackgroundColor,
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            height: 56,
            child: Row(
              children: [
                ImageConstants.iconBackGreen
                    .loadImageAsset(
                      height: 24,
                      width: 24,
                    )
                    .onCupertinoClick(context.pop),
                Text(
                  name ?? "",
                  style: AppTextStyles.bold,
                ).paddingOnly(left: 12).expanded(),
                Icon(
                  isLiked ? Icons.check_circle : Icons.add_circle_outline,
                  color: isLiked ? AppColors.primary : Colors.white,
                  size: 24,
                ).onCupertinoClick(favorite).paddingOnly(right: 10)
              ],
            ),
          ),
        ),
        SizedBox(
          height: (maxExtent - appBarHeight) * offset,
          child: Column(
            children: [
              Container(
                height: 250 * offset,
                width: 250 * offset,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: image.filePathUrl().loadImageUrl(
                      errorWidget: "music_placeholder".loadImageAsset(),
                      placeHolder: "music_placeholder".loadImageAsset(),
                    ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 30 * offset,
                  left: 17,
                  right: 17,
                ),
                height: 37 * offset,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(9),
                        color: AppColors.color444444,
                      ),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ImageConstants.iconPlayPrimary.loadImageAsset(
                            height: 14,
                            width: 14,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            "Play",
                            style: AppTextStyles.medium
                                .copyWith(color: AppColors.primary),
                          ),
                        ],
                      ),
                    ).onCupertinoClick(() {
                      onPlay(false);
                    }).expanded(),
                    const SizedBox(width: 17),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(9),
                        color: AppColors.color444444,
                      ),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ImageConstants.iconShufflePrimary.loadImageAsset(
                            height: 22.84,
                            width: 22.84,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            "Shuffle",
                            style: AppTextStyles.medium
                                .copyWith(color: AppColors.primary),
                          ),
                        ],
                      ),
                    ).onCupertinoClick(() {
                      onPlay(true);
                    }).expanded()
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  @override
  double get maxExtent => 350 + appBarHeight;

  @override
  double get minExtent => appBarHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}
