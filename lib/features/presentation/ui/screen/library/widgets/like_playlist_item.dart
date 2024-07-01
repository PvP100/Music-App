import 'package:flutter/material.dart';
import 'package:music_app/core/core.dart';

class LikePlaylistItem extends StatelessWidget {
  const LikePlaylistItem({super.key, required this.total});

  final int total;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                AppColors.colorFF9D9D,
                AppColors.colorFFE1E1,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.all(7.radius),
          ),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Bài hát ưa thích", style: AppTextStyles.regular),
            const SizedBox(height: 3),
            Text(
              "$total bài bát",
              style: AppTextStyles.regular.copyWith(fontSize: 12),
            )
          ],
        ).expanded()
      ],
    ).onCupertinoClick(() => _navigateToLike(context));
  }

  _navigateToLike(BuildContext context) {
    context.pushNamed(RouteConstants.like);
  }
}
