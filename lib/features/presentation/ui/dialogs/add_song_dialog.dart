import 'package:flutter/material.dart';
import 'package:music_app/core/core.dart';
import 'package:music_app/core/extensions/widget_extension.dart';

class AddSongDialog extends StatelessWidget {
  const AddSongDialog(
      {super.key, required this.onCreatePlaylist, required this.onSearch});

  final VoidCallback onCreatePlaylist;
  final VoidCallback onSearch;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: const BoxDecoration(
              color: ColorConstants.primaryBackgroundColor,
              borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
          padding: const EdgeInsets.only(bottom: 46, left: 15, top: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  height: 4,
                  width: 30,
                  decoration: const BoxDecoration(
                    color: ColorConstants.colorD9D9D9,
                    borderRadius: BorderRadius.all(Radius.circular(2)),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 29),
                alignment: Alignment.centerLeft,
                child: Text(
                  "Tạo playlist",
                  style: TextStyleConstants.medium,
                ),
              ).onCupertinoClick(() {
                context.pop();
                onCreatePlaylist();
              }),
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.symmetric(vertical: 24),
                child: Text(
                  "Tìm kiếm thêm album, nghệ sĩ",
                  style: TextStyleConstants.medium,
                ),
              ).onCupertinoClick(() async {
                context.pop();
                onSearch();
              }),
            ],
          ),
        ),
      ],
    );
  }
}
