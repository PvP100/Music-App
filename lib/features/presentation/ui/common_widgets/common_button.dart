import 'package:flutter/material.dart';
import 'package:music_app/core/core.dart';

class CommonButton extends StatelessWidget {
  const CommonButton({
    super.key,
    required this.title,
    this.backgroundColor = AppColors.primary,
    this.radius = 8,
    this.margin,
    this.titleColor = Colors.white,
    this.enableClick = true,
    required this.onClick,
  });

  final String title;
  final Color backgroundColor;
  final EdgeInsets? margin;
  final double radius;
  final bool enableClick;
  final Color titleColor;
  final VoidCallback onClick;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !enableClick,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 12),
        margin: margin,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(radius)),
        ),
        child: Text(
          title,
          style:
              AppTextStyles.bold.copyWith(height: 17 / 16, color: titleColor),
        ),
      ).onCupertinoClick(onClick),
    );
  }
}
