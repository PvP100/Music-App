import 'package:flutter/material.dart';

import '../../../../../../core/core.dart';

class TrackTimeWidget extends StatefulWidget {
  const TrackTimeWidget(
      {super.key, required this.totalMs, required this.currentTimeMs});

  final int totalMs;

  final int currentTimeMs;

  @override
  State<TrackTimeWidget> createState() => _TrackTimeWidgetState();
}

class _TrackTimeWidgetState extends State<TrackTimeWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          widget.currentTimeMs.convertToMinuteAndSecond(),
          style: AppTextStyles.medium.copyWith(fontSize: 14),
        ),
        Text(
          widget.totalMs.convertToMinuteAndSecond(),
          style: AppTextStyles.medium.copyWith(fontSize: 14),
        )
      ],
    );
  }
}
