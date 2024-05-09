import 'package:flutter/material.dart';
import 'package:music_app/core/constants/image_constants.dart';
import 'package:music_app/core/core.dart';

class AddPlaylistDialog extends StatefulWidget {
  const AddPlaylistDialog({super.key});

  @override
  State<AddPlaylistDialog> createState() => _AddPlaylistDialogState();
}

class _AddPlaylistDialogState extends State<AddPlaylistDialog> {
  late final TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          AppColors.color205E49,
          AppColors.color2F3035,
        ],
      )),
      child: FractionallySizedBox(
        heightFactor: 732 / 812,
        child: Stack(
          children: [
            Positioned(
              right: AppDimens.dimen20,
              top: AppDimens.dimen20,
              child: ImageConstants.iconCloseWhite
                  .loadImageAsset(
                    height: AppDimens.dimen24,
                    width: AppDimens.dimen24,
                  )
                  .onCupertinoClick(context.pop),
            ),
            Container(
              alignment: Alignment.topCenter,
              margin: const EdgeInsets.only(top: 155),
              child: Text(
                context.localizations().addNameForYourPlaylist,
                style: AppTextStyles.medium,
              ),
            ),
            Positioned(
              left: 41,
              right: 41,
              top: 232,
              child: TextField(
                textAlign: TextAlign.center,
                style: AppTextStyles.bold.copyWith(
                  fontSize: 24,
                  height: 30 / 24,
                  leadingDistribution: TextLeadingDistribution.even,
                ),
                decoration: const InputDecoration(
                    isDense: true,
                    focusColor: AppColors.primary,
                    focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: AppColors.colorD9D9D9, width: 0.5),
                    )),
                cursorColor: AppColors.primary,
                controller: _controller,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 302),
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.color04A63C,
                    borderRadius: BorderRadius.all(AppDimens.dimen15.radius),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 7,
                  ),
                  child: Text(
                    context.localizations().createStr,
                    style: AppTextStyles.medium.copyWith(
                      fontSize: 14,
                    ),
                  ),
                ).onCupertinoClick(() {}),
              ),
            )
          ],
        ),
      ),
    );
  }
}
