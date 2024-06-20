import 'package:flutter/material.dart';
import 'package:music_app/core/constants/image_constants.dart';
import 'package:music_app/core/core.dart';

class AlbumHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double appBarHeight;

  AlbumHeaderDelegate({required this.appBarHeight});

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
                  "34234",
                  style: AppTextStyles.bold,
                ).paddingOnly(left: 12).expanded()
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
                child:
                    "https://letsenhance.io/static/8f5e523ee6b2479e26ecc91b9c25261e/1015f/MainAfter.jpg"
                        .loadImageUrl(),
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
                    ).expanded(),
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
                    ).expanded()
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
