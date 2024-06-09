import 'package:flutter/material.dart';

import '../../../../../../core/core.dart';

class TrackTimeWidget extends StatelessWidget {
  const TrackTimeWidget(
      {super.key, required this.totalMs, required this.currentTimeMs});

  final int totalMs;

  final int currentTimeMs;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          currentTimeMs.convertToMinuteAndSecond(),
          style: AppTextStyles.medium.copyWith(fontSize: 14),
        ),
        Text(
          "-${totalMs.convertToMinuteAndSecond()}",
          style: AppTextStyles.medium.copyWith(fontSize: 14),
        )
      ],
    );
  }
}
