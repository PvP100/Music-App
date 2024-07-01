import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:music_app/core/core.dart';

class AppCircleAvatar extends StatelessWidget {
  const AppCircleAvatar({super.key, required this.url});

  final String? url;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 20,
      foregroundImage: CachedNetworkImageProvider(url?.filePathUrl() ?? ""),
    ).onCupertinoClick(() {
      context.pushNamed(RouteConstants.profile);
    });
  }
}
