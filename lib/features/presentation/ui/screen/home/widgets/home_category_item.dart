import 'package:flutter/material.dart';
import 'package:music_app/core/core.dart';

class HomeCategoryItem extends StatelessWidget {
  const HomeCategoryItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Dành cho bạn",
          style: TextStyleConstants.bold.copyWith(fontSize: 20),
        ).paddingOnly(left: 15, bottom: 8),
        SizedBox(
          height: 221,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemBuilder: (context, index) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  child:
                      "https://i.scdn.co/image/ab67616d0000b27353c7b04cd06067647760188e"
                          .loadImageUrl(height: 150, width: 150),
                ),
                Text(
                  "Secret Path",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyleConstants.medium.copyWith(fontSize: 14),
                ).paddingOnly(top: 8, bottom: 2),
                Text(
                  "Dontcry, Noflik, Showyou",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyleConstants.regular.copyWith(fontSize: 12),
                )
              ],
            ),
            separatorBuilder: (context, index) => const SizedBox(width: 15),
            itemCount: 10,
          ),
        )
      ],
    );
  }
}
