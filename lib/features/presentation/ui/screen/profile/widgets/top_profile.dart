import 'package:flutter/material.dart';

import '../../../../../../core/core.dart';

class TopProfile extends StatelessWidget {
  const TopProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 18),
      decoration: BoxDecoration(
          color: AppColors.color4A4A4A,
          borderRadius: BorderRadius.all(10.radius)),
      child: Column(children: [
        const CircleAvatar(
          radius: 50,
        ).align(heightFactor: 0.5, alignment: Alignment.bottomCenter),
        Text(
          "Phạm Việt Phong",
          style: AppTextStyles.bold.copyWith(fontSize: 20),
        ).paddingOnly(top: 17, bottom: 22),
        Row(
          children: [
            Column(
              children: [
                Text(
                  "10",
                  style: AppTextStyles.bold.copyWith(fontSize: 18),
                ),
                Text(
                  "Đang theo dõi",
                  style: AppTextStyles.medium.copyWith(
                    fontSize: 14,
                    color: AppColors.colorCACACA,
                  ),
                )
              ],
            ).expanded(),
            const SizedBox(
              height: 30,
              child: VerticalDivider(
                width: 1,
                thickness: 1,
              ),
            ),
            Column(
              children: [
                Text(
                  "99",
                  style: AppTextStyles.bold.copyWith(fontSize: 18),
                ),
                Text(
                  "Bài hát yêu thích",
                  style: AppTextStyles.medium.copyWith(
                    fontSize: 14,
                    color: AppColors.colorCACACA,
                  ),
                )
              ],
            ).expanded(),
          ],
        )
      ]),
    );
  }
}
