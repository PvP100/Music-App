import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:music_app/core/core.dart';

class AppCircleAvatar extends StatelessWidget {
  const AppCircleAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
      radius: 20,
      foregroundImage: CachedNetworkImageProvider(
          "https://images.unsplash.com/photo-1692221307059-8819db116d92?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=987&q=80"),
    ).onCupertinoClick(() {
      context.pushNamed(RouteConstants.profile);
    });
  }
}
