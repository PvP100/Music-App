import 'package:flutter/material.dart';
import 'package:music_app/core/core.dart';
import 'package:music_app/features/domain/entities/home_menu_entity.dart';

class HomeCategoryItem extends StatelessWidget {
  const HomeCategoryItem({super.key, this.entity});

  final HomeMenuEntity? entity;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          entity?.title ?? "",
          style: AppTextStyles.bold.copyWith(fontSize: 20),
        ).paddingOnly(left: 15, bottom: 8),
        SizedBox(
          height: 221,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final model = entity?.data?[index];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    child: model?.thumbnail?.loadImageUrl(
                      height: 150,
                      width: 150,
                      placeHolder: "music_placeholder".loadImageAsset(),
                      errorWidget: "music_placeholder".loadImageAsset(),
                    ),
                  ).onCupertinoClick(() => _navigateToAlbumScreen(context)),
                  Text(
                    model?.name ?? "",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.medium.copyWith(fontSize: 14),
                  ).paddingOnly(top: 8, bottom: 2),
                  Text(
                    model?.artists ?? "",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.regular.copyWith(fontSize: 12),
                  )
                ],
              );
            },
            separatorBuilder: (context, index) => const SizedBox(width: 15),
            itemCount: entity?.data?.length ?? 0,
          ),
        )
      ],
    );
  }

  _navigateToAlbumScreen(BuildContext context) {}
}
