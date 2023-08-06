import 'package:flutter/material.dart';
import 'package:music_app/core/constants/image_constants.dart';
import 'package:music_app/core/core.dart';

class HaMusicAppBar extends StatelessWidget {
  const HaMusicAppBar({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Stack(children: [
        Container(
          margin: const EdgeInsets.only(left: 15),
          alignment: Alignment.centerLeft,
          child: ImageConstants.iconBack.loadImageAsset(height: 30, width: 30),
        ),
        Align(
          alignment: Alignment.center,
          child: Text(
            title,
            style: TextStyleConstants.regular.copyWith(fontSize: 17),
          ),
        )
      ]),
    );
  }
}
