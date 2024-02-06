import 'package:flutter/material.dart';
import 'package:music_app/core/constants/image_constants.dart';
import 'package:music_app/core/core.dart';

class HaMusicAppBar extends StatelessWidget {
  const HaMusicAppBar(
      {super.key, this.title, this.rightIcon, this.onRightClick});

  final String? title;
  final Widget? rightIcon;
  final VoidCallback? onRightClick;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Stack(children: [
        Positioned(
          left: 15,
          top: 0,
          bottom: 0,
          child: ImageConstants.iconBack
              .loadImageAsset(height: 30, width: 30)
              .onCupertinoClick(() => context.pop()),
        ),
        if (title != null) ...{
          Align(
            alignment: Alignment.center,
            child: Text(
              title!,
              style: AppTextStyles.medium.copyWith(fontSize: 17),
            ),
          ),
        },
        if (rightIcon != null) ...{
          Positioned(
            top: 0,
            bottom: 0,
            right: 15,
            child: rightIcon!.onCupertinoClick(() => onRightClick?.call()),
          )
        }
      ]),
    );
  }
}
