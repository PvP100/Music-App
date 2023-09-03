import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:music_app/features/data/exception/failure.dart';

extension StringExtension on String? {
  bool isPhoneNumber() {
    if (this == null) return false;
    if (this!.length < 9 || this!.length > 12) {
      return false;
    }
    return true;
  }

  Failure toFailure() => Failure.error(this ?? "");

  Widget loadImageUrl({
    Widget? placeHolder,
    Widget? errorWidget,
    BoxFit fit = BoxFit.cover,
    double? width,
    double? height,
    int? memCacheWidth,
    int? memCacheHeight,
  }) {
    if (this != null && this?.isNotEmpty == true) {
      return CachedNetworkImage(
        memCacheHeight: memCacheHeight,
        memCacheWidth: memCacheWidth,
        height: height,
        width: width,
        fit: fit,
        imageUrl: this!,
        errorWidget: (context, url, error) => errorWidget ?? const SizedBox(),
        placeholder: (context, url) =>
            placeHolder ?? const CircularProgressIndicator(),
      );
    } else {
      return const SizedBox();
    }
  }

  Widget loadImageAsset(
      {String withExtension = "png",
      BoxFit fit = BoxFit.cover,
      double? width,
      double? height,
      int? memCacheWidth,
      int? memCacheHeight}) {
    return Image.asset(
      "assets/images/$this.$withExtension",
      fit: fit,
      cacheHeight: memCacheHeight,
      cacheWidth: memCacheWidth,
      height: height,
      width: width,
    );
  }
}
