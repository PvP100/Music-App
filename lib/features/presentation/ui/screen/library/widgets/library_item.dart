import 'package:flutter/material.dart';
import 'package:music_app/core/constants/constants.dart';
import 'package:music_app/core/core.dart';
import 'package:music_app/core/extensions/widget_extension.dart';

class LibraryItem extends StatelessWidget {
  const LibraryItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 50,
          width: 50,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                ColorConstants.colorFF9D9D,
                ColorConstants.colorFFE1E1,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.all(Radius.circular(7)),
          ),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Bai hat ua thich", style: TextStyleConstants.regular),
            const SizedBox(height: 3),
            Text(
              "87 bai hat",
              style: TextStyleConstants.regular.copyWith(fontSize: 12),
            )
          ],
        ).expanded()
      ],
    );
  }
}
