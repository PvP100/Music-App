import 'package:flutter/material.dart';
import 'package:music_app/core/constants/image_constants.dart';
import 'package:music_app/core/core.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({
    super.key,
    this.focusNode,
    required this.controller,
    required this.onSearch,
  });

  final FocusNode? focusNode;
  final TextEditingController controller;
  final ValueChanged<String> onSearch;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      decoration: const BoxDecoration(
        color: AppColors.color454545,
        borderRadius: BorderRadius.all(Radius.circular(7)),
      ),
      child: Row(children: [
        ImageConstants.iconSearch
            .loadImageAsset(height: 14, width: 14)
            .paddingOnly(left: 5),
        TextField(
          onSubmitted: onSearch,
          focusNode: focusNode,
          controller: controller,
          textInputAction: TextInputAction.search,
          cursorColor: AppColors.primary,
          style: AppTextStyles.medium.copyWith(fontSize: 12, height: 14 / 12),
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 5,
              vertical: 6,
            ),
            isDense: true,
            hintText: context.localizations().searchHint,
            hintStyle: AppTextStyles.medium.copyWith(
              fontSize: 12,
              color: AppColors.colorA4A4A4,
              height: 14 / 12,
            ),
          ),
        ).expanded(),
        ValueListenableBuilder(
            valueListenable: controller,
            child: const Icon(
              Icons.close,
              color: Colors.white,
            ).onCupertinoClick(() {
              controller.clear();
            }, hideKeyboard: false),
            builder: (context, value, child) {
              return Visibility(
                  visible: value.text.trim().isNotEmpty, child: child!);
            })
      ]),
    );
  }
}
