import 'package:flutter/material.dart';
import 'package:music_app/core/core.dart';
import 'package:music_app/features/domain/entities/search_entity.dart';

class ArtistItemWidget extends StatelessWidget {
  const ArtistItemWidget({super.key, this.entity});

  final SearchEntity? entity;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(children: [
        Container(
          height: 50,
          width: 50,
          clipBehavior: Clip.hardEdge,
          decoration: const BoxDecoration(shape: BoxShape.circle),
          child: entity?.image.filePathUrl().loadImageUrl(
                errorWidget: "music_placeholder".loadImageAsset(),
                placeHolder: "music_placeholder".loadImageAsset(),
              ),
        ),
        const SizedBox(width: 12),
        Text(
          entity?.name ?? "",
          maxLines: 1,
          style: AppTextStyles.regular,
          overflow: TextOverflow.ellipsis,
        ).expanded(),
      ]),
    ).onCupertinoClick(() => _navigateToArtist(context));
  }

  _navigateToArtist(BuildContext context) {
    context.pushNamed(RouteConstants.artist, arguments: {
      ArgumentKey.artistId: entity?.id,
    });
  }
}
