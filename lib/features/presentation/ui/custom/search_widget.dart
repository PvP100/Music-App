import 'package:flutter/material.dart';
import 'package:music_app/core/constants/image_constants.dart';
import 'package:music_app/core/core.dart';
import 'package:music_app/core/extensions/widget_extension.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({super.key});

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      decoration: const BoxDecoration(
        color: ColorConstants.color454545,
        borderRadius: BorderRadius.all(Radius.circular(7)),
      ),
      child: Row(children: [
        ImageConstants.iconSearch
            .loadImageAsset(height: 14, width: 14)
            .paddingOnly(left: 5),
        TextField(
          cursorColor: ColorConstants.primary,
          style:
              TextStyleConstants.medium.copyWith(fontSize: 12, height: 14 / 12),
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 5,
              vertical: 6,
            ),
            isDense: true,
            hintText: "Nghệ sĩ, Bài hát, Album, v.v.",
            hintStyle: TextStyleConstants.medium.copyWith(
                fontSize: 12,
                color: ColorConstants.colorA4A4A4,
                height: 14 / 12),
          ),
        ).expanded()
      ]),
    );
  }
}
